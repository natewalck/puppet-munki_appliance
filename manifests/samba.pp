# Setup samba share for munki appliance
class munki_appliance::samba {
  $munki_user = $munki_appliance::munki_user
  $munki_root = $munki_appliance::munki_root
  $admin_password= '123456',

  class { 'samba::server':

    workgroup            => 'munki',
    server_string        => 'Munki',
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
        'comment = Munki Repo',
        "path = ${munki_root}/repo",
        'browseable = yes',
        'writable = yes',
        "valid users = ${munki_user}",
      ],
    },
    selinux_enable_home_dirs => false,
  }

  exec { 'createsuperuser':
    command     => "echo -ne "${admin_password}\n${admin_password}\n" | smbpasswd -a -s ${munki_user}",
    unless      => "pdbedit -L | grep ${munki_user}",
    require     => Class['samba::server'],
  }
}