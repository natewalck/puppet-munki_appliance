# /etc/puppet/modules/munki_appliance/manifests/install.pp

class munki_appliance::install {

  class { 'apache': default_vhost => false, }

  package { 'git': ensure => present, }

  class { 'python':
    version    => 'system',
    dev        => true,
    virtualenv => true,
    pip        => true,
  }

  file { '/etc/munkiwebadmin': ensure => directory, }
  file { '/etc/munkiwebadmin/requirements.txt':
    content => 'django==1.5.1',
    require => File['/etc/munkiwebadmin'],
  }

}