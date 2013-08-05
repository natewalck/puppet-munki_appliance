# /etc/puppet/modules/munki_appliance/manifests/virtualenv.pp

class munki_appliance::virtualenv {

  python::virtualenv { '/opt/munkiwebadmin_env':
    ensure  => present,
    version => 'system',
    owner   => 'munkiwebadmin',
    group   => 'munkiwebadmin',
  }
}