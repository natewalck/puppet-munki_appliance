# /etc/puppet/modules/munki_appliance/manifests/install.pp

class munki_appliance::install {

  class { 'apache': default_vhost => false, }

  package { 'git': ensure => present, }

  class { 'python':
    version => 'system',
    virtualenv => true,
  }
}