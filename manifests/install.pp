# /etc/puppet/modules/munki_appliance/manifests/install.pp

class munki_appliance::install {
  $munki_web_admin_data = $munki_appliance::munki_web_admin_data

  class { 'apache': default_vhost => false, }

  package { 'git': ensure => present, }

  class { 'python':
    version    => 'system',
    dev        => true,
    virtualenv => true,
    pip        => true,
  }

  file { $munki_web_admin_data : ensure => directory, }
  file { "${$munki_web_admin_data}/requirements.txt" :
    content => 'django==1.5.1',
    require => File[$munki_web_admin_data],
  }

}