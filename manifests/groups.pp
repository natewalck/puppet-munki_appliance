# /etc/puppet/modules/munki_appliance/manifests/groups.pp

class munki_appliance::groups {
  $munki_group = $munki_appliance::munki_group

    group { $munki_group : ensure => present, }

}