# /etc/puppet/modules/munki_appliance/manifests/munki_dirs.pp
class munki_appliance::munki_dirs{
  $new_repo  = $munki_appliance::new_repo
  $repo_src = $munki_appliance::repo_src
  $device  = $munki_appliance::device
  $share  = $munki_appliance::share
  $admin_password  = $munki_appliance::admin_password
  $munki_root  = $munki_appliance::munki_root
  $munki_user  = $munki_appliance::munki_user
  $munki_group = $munki_appliance::munki_group
  $munki_dirs  = ["${munki_root}/repo/catalogs", "${munki_root}/repo/manifests",
  "${munki_root}/repo/pkgs", "${munki_root}/repo/pkgsinfo"]

  case $new_repo {
    'mount': {
      ensure_packages(["cifs-utils", "samba-client", "samba-common"])
      file { "${munki_root}/repo" :
      ensure => 'directory',
      }
      mount {'munki_repo':
        atboot   => true,
        name     => "${munki_root}/repo",
        device   => "//$device/$share",
        ensure   => 'mounted',
        fstype   => 'cifs',
        options  => "user=$munki_user,password=$admin_password",
      }
    }
    default: {
      vcsrepo { "${munki_root}/repo" :
        ensure   => present,
        provider => git,
        owner   => $munki_user,
        group   => $munki_group,
        source   => "$repo_src"
      }

      file { $munki_dirs :
        ensure  => 'directory',
        recurse => true,
        owner   => $munki_user,
        group   => $munki_group,
        mode    => '0664',
        require => Vcsrepo["${munki_root}/repo"],
      }
    }
  }
}

