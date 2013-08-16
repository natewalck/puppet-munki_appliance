# /etc/puppet/modules/munki_appliance/manifests/virtualenv.pp

class munki_appliance::virtualenv {
  $mwa_service_account  = $munki_appliance::mwa_service_account
  $mwa_dir  = $munki_appliance::mwa_dir
  $munki_web_admin_data = $munki_appliance::munki_web_admin_data

  file { '/opt': ensure => directory, owner => $mwa_service_account, }

  python::virtualenv { $mwa_dir :
    ensure       => present,
    version      => 'system',
    requirements => "${munki_web_admin_data}/requirements.txt",
    owner        => $mwa_service_account,
    group        => $mwa_service_account,
    require      => File['/opt'],
  }
}