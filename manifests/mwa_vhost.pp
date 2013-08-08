# /etc/puppet/modules/munki_appliance/manifests/mwa_vhost.pp

class munki_appliance::mwa_vhost {
  $munki_web_admin_dir = $munki_appliance::munki_web_admin_dir
  $munki_web_admin_user = $munki_appliance::munki_web_admin_user

  $http_path = $::osfamily ? {
    'RedHat' => '/etc/httpd/conf.d',
    'Debian' => '/etc/apache2/sites-available'
  }

  file { "${http_path}/25-${::hostname}.conf" :
    ensure => present,
    content => template('munki_appliance/25-puppetdev01.conf.erb'),
  }


}