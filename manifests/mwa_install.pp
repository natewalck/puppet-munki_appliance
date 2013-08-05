# /etc/puppet/modules/munki_appliance/manifests/mwa_install.pp

class munki_appliance::mwa_install {
  $munki_web_admin_user = $munki_appliance::munki_web_admin_user
  $munki_web_admin_dir = $munki_appliance::munki_web_admin_dir
  $munki_web_admin_data = $munki_appliance::munki_web_admin_data

  vcsrepo { "${munki_web_admin_dir}/munkiwebadmin" :
    ensure   => latest,
    provider => git,
    source   => 'https://code.google.com/p/munki.munkiwebadmin',
    revision => "master",
    owner    => $munki_web_admin_user,
    group    => $munki_web_admin_user,
    require  => Package['git'],
  }
}