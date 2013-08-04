# /etc/puppet/modules/munki_appliance/manifests/config.pp

class munki_appliance::config{
  $munki_root  = $munki_appliance::munki_root
  $munki_port  = $munki_appliance::munki_port
  $munki_user  = $munki_appliance::munki_user
  $munki_group = $munki_appliance::munki_group
  $ssl_enabled = $munki_appliance::ssl_enabled
  $ssl_cert    = $munki_appliance::ssl_cert
  $ssl_key     = $munki_appliance::ssl_key
  $munki_dirs  = ["${munki_root}/repo/catalogs", "${munki_root}/repo/manifests",
                  "${munki_root}/repo/pkgs", "${munki_root}/repo/pkgsinfo"]

  apache::vhost { $::fqdn :
    port          => $munki_port,
    docroot       => $munki_root,
    docroot_owner => $munki_user,
    docroot_group => $munki_user,
    options       => ['-Indexes'],
    ssl           => $ssl_enabled,
    ssl_cert      => $ssl_cert,
    ssl_key       => $ssl_key,
  }

  file { "${munki_root}/repo":
    ensure  => 'directory',
    recurse => true,
    owner   => $munki_user,
    group   => $munki_group,
  }

  file { $munki_dirs:
    ensure  => 'directory',
    owner   => $munki_user,
    group   => $munki_group,
    require => File["${munki_root}/repo"],
  }
}