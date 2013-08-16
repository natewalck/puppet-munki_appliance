# /etc/puppet/modules/munki_appliance/manifests/mwa_config.pp

class munki_appliance::mwa_config {
  $munki_web_admin_dir = $munki_appliance::munki_web_admin_dir
  $mwa_service_account = $munki_appliance::mwa_service_account
  $admin_username      = $munki_appliance::admin_username
  $admin_password      = $munki_appliance::admin_password

  $http_dir = $::osfamily ? {
    'RedHat' => '/etc/httpd/conf/',
    'Debian' => '/etc/apache2/'
  }

  $http_conf = $::osfamily ? {
    'RedHat' => 'httpd.conf',
    'Debian' => 'apache2.conf'
  }

  include apache::mod::wsgi

  exec { 'syncdb':
    user        => $mwa_service_account,
    command     => 'python manage.py syncdb --noinput',
    cwd         => "${munki_web_admin_dir}/munkiwebadmin",
    path        => "${munki_web_admin_dir}/bin",
    creates     => "${munki_web_admin_dir}/munkiwebadmin/munkiwebadmin.db"
  }

  exec { 'collectstatic':
    user        => $mwa_service_account,
    command     => 'python manage.py collectstatic --noinput',
    cwd         => "${munki_web_admin_dir}/munkiwebadmin",
    path        => "${munki_web_admin_dir}/bin",
    creates     => "${munki_web_admin_dir}/munkiwebadmin/static/admin"
  }

  exec { 'createsuperuser':
    user        => $mwa_service_account,
    command     => "python createsuperuser.py --username ${admin_username} --password ${admin_password}",
    cwd         => "${munki_web_admin_dir}/munkiwebadmin",
    path        => "${munki_web_admin_dir}/bin",
    unless      => "python doesuserexist.py --username=${admin_username}",
    require     => Exec['syncdb'],
  }

  file { '/var/run/wsgi' :
    ensure => directory,
    owner  => $mwa_service_account,
    group  => 'root',
  }

  file_line { 'wsgi socket prefix' :
    path    => "${http_dir}/${http_conf}",
    line    => 'WSGISocketPrefix /var/run/wsgi',
    require => File['/var/run/wsgi'],
  }

  file { "${munki_web_admin_dir}/munkiwebadmin/munkiwebadmin.wsgi" :
    ensure  => present,
    owner   => $mwa_service_account,
    group   => $mwa_service_account,
    content => template('munki_appliance/munkiwebadmin.wsgi.erb'),
  }

}