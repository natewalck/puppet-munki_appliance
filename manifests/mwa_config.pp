# /etc/puppet/modules/munki_appliance/manifests/mwa_config.pp

class munki_appliance::mwa_config {
  $munki_web_admin_dir = $munki_appliance::munki_web_admin_dir
  $admin_username  = $munki_appliance::admin_username
  $admin_password  = $munki_appliance::admin_password

  exec { 'syncdb':
    command     => 'python manage.py syncdb --noinput',
    cwd         => "${munki_web_admin_dir}/munkiwebadmin",
    path        => "${munki_web_admin_dir}/bin",
    creates     => "${munki_web_admin_dir}/munkiwebadmin/munkiwebadmin.db"
  }
}

  exec { 'createsuperuser':
    command     => "python createsuperuser.py --username ${admin_username} --password ${admin_password}",
    cwd         => "${munki_web_admin_dir}/munkiwebadmin",
    path        => "${munki_web_admin_dir}/bin",
    unless      => "python doesuserexist.py --username=${admin_username}"
  }