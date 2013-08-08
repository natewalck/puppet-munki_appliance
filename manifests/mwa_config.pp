# /etc/puppet/modules/munki_appliance/manifests/mwa_config.pp

class munki_appliance::mwa_config {
  $munki_web_admin_dir = $munki_appliance::munki_web_admin_dir
  $munki_web_admin_user = $munki_appliance::munki_web_admin_user
  $admin_username  = $munki_appliance::admin_username
  $admin_password  = $munki_appliance::admin_password

  $httpconf = $::osfamily ? {
    'RedHat' => '/etc/httpd/conf/httpd.conf',
    'Debian' => '/etc/apache2/apache2.conf'
  }

  include apache::mod::wsgi

  exec { 'syncdb':
    user        => $munki_web_admin_user,
    command     => 'python manage.py syncdb --noinput',
    cwd         => "${munki_web_admin_dir}/munkiwebadmin",
    path        => "${munki_web_admin_dir}/bin",
    creates     => "${munki_web_admin_dir}/munkiwebadmin/munkiwebadmin.db"
  }

  exec { 'createsuperuser':
    user        => $munki_web_admin_user,
    command     => "python createsuperuser.py --username ${admin_username} --password ${admin_password}",
    cwd         => "${munki_web_admin_dir}/munkiwebadmin",
    path        => "${munki_web_admin_dir}/bin",
    unless      => "python doesuserexist.py --username=${admin_username}",
    require     => Exec['syncdb'],
  }

  file { '/var/run/wsgi' :
    ensure => directory,
    owner => $munki_web_admin_user,
    group => 'root',
  }

  file_line { 'wsgi socket prefix' :
    path => $httpconf,
    line => 'WSGISocketPrefix /var/run/wsgi',
    require => File['/var/run/wsgi'],
  }

  file { "${munki_web_admin_dir}/munkiwebadmin/munkiwebadmin.wsgi" :
    ensure => present,
    owner => $munki_web_admin_user,
    group => $munki_web_admin_user,
    content => template('munki_appliance/munkiwebadmin.wsgi.erb'),
  }

}