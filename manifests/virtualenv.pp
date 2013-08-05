# /etc/puppet/modules/munki_appliance/manifests/virtualenv.pp

class munki_appliance::virtualenv {
  $munki_web_admin_user = $munki_appliance::munki_web_admin_user


  file { '/opt': ensure => directory, owner => $munki_web_admin_user, }

  python::virtualenv { '/opt/munkiwebadmin_env':
    ensure       => present,
    version      => 'system',
    requirements => '/etc/munkiwebadmin/requirements.txt',
    owner        => $munki_web_admin_user,
    group        => $munki_web_admin_user,
    require      => File['/opt'],
  }
}