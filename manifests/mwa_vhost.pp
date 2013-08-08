# /etc/puppet/modules/munki_appliance/manifests/mwa_vhost.pp

class munki_appliance::mwa_vhost {
  $munki_web_admin_dir = $munki_appliance::munki_web_admin_dir
  $munki_web_admin_user = $munki_appliance::munki_web_admin_user
  $munki_web_admin_port = $munki_appliance::munki_web_admin_port

  $http_config_path = $::osfamily ? {
    'RedHat' => '/etc/httpd/conf.d',
    'Debian' => '/etc/apache2/sites-enabled'
  }

  $http_dir = $::osfamily ? {
    'RedHat' => '/etc/httpd/conf/',
    'Debian' => '/etc/apache2/'
  }

  file { "${http_config_path}/25-${::hostname}.conf" :
    ensure => present,
    content => template('munki_appliance/25-puppetdev01.conf.erb'),
    notify  => Service['httpd'],
  }

  file_line { 'set NameVirtualHost port' :
    path => "${http_dir}/ports.conf",
    line => "NameVirtualHost *:${munki_web_admin_port}",
  }

  file_line { 'set listen port' :
    path => "${http_dir}/ports.conf",
    line => "Listen ${munki_web_admin_port}",
    notify  => Service['httpd'],
  }

}