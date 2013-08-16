# /etc/puppet/modules/munki_appliance/manifests/users.pp

class munki_appliance::users {

  $munki_user          = $munki_appliance::munki_user
  $mwa_service_account = $munki_appliance::mwa_service_account

  user { $munki_user :
    ensure => present,
    groups => munki,
  }

  user { $mwa_service_account :
    ensure => present,
    groups => munki,
  }
}