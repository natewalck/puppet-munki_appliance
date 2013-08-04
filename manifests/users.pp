# /etc/puppet/modules/munki_appliance/manifests/users.pp

class munki_appliance::users {

  $munki_user = $munki_appliance::munki_user
  $munki_web_admin_user = $munki_appliance::munki_web_admin_user

  user { $munki_user :
    ensure => present,
    groups => munki,
  }

  user { $munki_web_admin_user :
    ensure => present,
    groups => munki,
  }
}