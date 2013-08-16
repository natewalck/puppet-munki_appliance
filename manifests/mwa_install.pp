# /etc/puppet/modules/munki_appliance/manifests/mwa_install.pp

class munki_appliance::mwa_install {
  $munki_web_admin_user = $munki_appliance::munki_web_admin_user
  $munki_web_admin_dir  = $munki_appliance::munki_web_admin_dir
  $munki_web_admin_data = $munki_appliance::munki_web_admin_data
  $munki_root           = $munki_appliance::munki_root
  $time_Zone            = $munki_appliance::time_zone
  $admin_name           = $munki_appliance::admin_name
  $admin_email          = $munki_appliance::admin_email

  vcsrepo { "${munki_web_admin_dir}/munkiwebadmin" :
    ensure   => latest,
    provider => git,
    source   => 'https://code.google.com/p/munki.munkiwebadmin',
    revision => 'master',
    owner    => $munki_web_admin_user,
    group    => $munki_web_admin_user,
    require  => Package['git'],
  }

  file { "${munki_web_admin_dir}/munkiwebadmin/settings.py" :
    ensure  => present,
    group   => $munki_web_admin_user,
    mode    => '0644',
    owner   => $munki_web_admin_user,
    content => template('munki_appliance/settings.py.erb'),
    require => Vcsrepo["${munki_web_admin_dir}/munkiwebadmin"],
  }

  file { "${munki_web_admin_dir}/munkiwebadmin/createsuperuser.py" :
    ensure  => 'file',
    source  => 'puppet:///modules/munki_appliance/createsuperuser.py',
    group   => $munki_web_admin_user,
    mode    => '0644',
    owner   => $munki_web_admin_user,
    require => Vcsrepo["${munki_web_admin_dir}/munkiwebadmin"],
  }

  file { "${munki_web_admin_dir}/munkiwebadmin/doesuserexist.py" :
    ensure  => 'file',
    source  => 'puppet:///modules/munki_appliance/doesuserexist.py',
    group   => $munki_web_admin_user,
    mode    => '0644',
    owner   => $munki_web_admin_user,
    require => Vcsrepo["${munki_web_admin_dir}/munkiwebadmin"],
  }
}