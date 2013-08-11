# /etc/puppet/modules/munki_appliance/manifests/samba.pp

class munki_appliance::samba {
  $munki_root = $munki_appliance::munki_root
  $munki_user = $munki_appliance::munki_user
  $munki_samba_password = $munki_appliance::munki_samba_password

  class { 'samba::server':
    workgroup            => 'munki',
    server_string        => 'Munki Appliance',
    netbios_name         => 'munki',
    interfaces           => [ 'lo', 'eth0' ],
    hosts_allow          => [ ],
    local_master         => 'yes',
    map_to_guest         => 'Bad User',
    os_level             => '50',
    preferred_master     => 'yes',
    extra_global_options => [
      'printing = BSD',
      'printcap name = /dev/null',
    ],
    shares => {
      'repo' => [
        'comment = Pictures',
        "path = ${munki_root}/repo",
        'browseable = yes',
        'writable = yes',
        'guest ok = no',
        'available = yes',
        'valid users = munki',
      ],
    },
    selinux_enable_home_dirs => false,
  }

# exec { 'create samba password':
#   command     => "",
#   unless      => "",
#   require     => Class[samba::server],
# }
}