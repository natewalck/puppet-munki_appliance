# /etc/puppet/modules/munki_appliance/manifests/virtualenv.pp

class munki_appliance::virtualenv {
  $munki_web_admin_user = $munki_appliance::munki_web_admin_user
  $munki_web_admin_dir  = $munki_appliance::munki_web_admin_dir
  $munki_web_admin_data = $munki_appliance::munki_web_admin_data

  file { '/opt': ensure => directory, owner => $munki_web_admin_user, }

  python::virtualenv { $munki_web_admin_dir :
    ensure       => present,
    version      => 'system',
    requirements => "${munki_web_admin_data}/requirements.txt",
    owner        => $munki_web_admin_user,
    group        => $munki_web_admin_user,
    require      => File['/opt'],
  }
}