# /etc/puppet/modules/munki_appliance/manifests/virtualenv.pp

class munki_appliance::virtualenv {
  $mwa_service_account = $munki_appliance::mwa_service_account
  $mwa_dir             = $munki_appliance::mwa_dir
  $mwa_data            = $munki_appliance::mwa_data

  file { '/opt': ensure => directory, owner => $mwa_service_account, }

  python::virtualenv { $mwa_dir :
    ensure       => present,
    version      => 'system',
    requirements => "${mwa_data}/requirements.txt",
    owner        => $mwa_service_account,
    group        => $mwa_service_account,
    require      => File['/opt'],
  }
}