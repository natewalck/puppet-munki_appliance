# /etc/puppet/modules/munki_appliance/manifests/install.pp

class munki_appliance::install {
  $mwa_data = $munki_appliance::mwa_data

  class { 'apache': default_vhost => false, }

  package { 'git': ensure => present, }

  class { 'python':
    version    => 'system',
    dev        => true,
    virtualenv => true,
    pip        => true,
  }

  file { $mwa_data : ensure => directory, }
  file { "${$mwa_data}/requirements.txt" :
    content => 'django==1.5.1',
    require => File[$mwa_data],
  }
}