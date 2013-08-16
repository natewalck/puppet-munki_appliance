# /etc/puppet/modules/munki_appliance/manifests/mwa_vhost.pp

class munki_appliance::mwa_vhost {
  $mwa_dir             = $munki_appliance::mwa_dir
  $mwa_service_account = $munki_appliance::mwa_service_account
  $mwa_port            = $munki_appliance::mwa_port

  $http_config_path = $::osfamily ? {
    'RedHat' => '/etc/httpd/conf.d',
    'Debian' => '/etc/apache2/sites-enabled'
  }

  $http_dir = $::osfamily ? {
    'RedHat' => '/etc/httpd/conf/',
    'Debian' => '/etc/apache2/'
  }

  file { "${http_config_path}/25-${::hostname}.conf" :
    ensure  => present,
    content => template('munki_appliance/munkiwebadmin.conf.erb'),
    notify  => Service['httpd'],
  }

  file_line { 'set NameVirtualHost port' :
    path => "${http_dir}/ports.conf",
    line => "NameVirtualHost *:${mwa_port}",
  }

  file_line { 'set listen port' :
    path   => "${http_dir}/ports.conf",
    line   => "Listen ${mwa_port}",
    notify => Service['httpd'],
  }

}