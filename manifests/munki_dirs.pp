# /etc/puppet/modules/munki_appliance/manifests/munki_dirs.pp

class munki_appliance::munki_dirs{
  $munki_root  = $munki_appliance::munki_root
  $munki_user  = $munki_appliance::munki_user
  $munki_group = $munki_appliance::munki_group
  $munki_dirs  = ["${munki_root}/repo/catalogs", "${munki_root}/repo/manifests",
                  "${munki_root}/repo/pkgs", "${munki_root}/repo/pkgsinfo"]

  file { $munki_dirs:
    ensure  => 'directory',
    owner   => $munki_user,
    group   => $munki_group,
  }
}