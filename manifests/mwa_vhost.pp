# /etc/puppet/modules/munki_appliance/manifests/mwa_config.pp

class munki_appliance::mwa_config {
  $munki_web_admin_dir = $munki_appliance::munki_web_admin_dir
  $munki_web_admin_user = $munki_appliance::munki_web_admin_user

  $http_path = $::osfamily ? {
    'RedHat' => '/etc/httpd/conf.d',
    'Debian' => '/etc/apache2/sites-available'
  }

  file { "${http_path}/25-${::hostname}.conf" :
    ensure => present,
  }


}