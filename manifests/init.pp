# /etc/puppet/modules/munki_appliance/manifests/init.pp
class munki_appliance(
  $munki_root  = '/var/www/munki',
  $munki_port  = '80',
  $munki_user  = 'munki',
  $munki_group = 'munki',
  $munki_web_admin_user  = 'munkiwebadmin',
  $munki_web_admin_dir   = '/opt/munkiwebadmin_env',
  $munki_web_admin_data  = '/etc/munkiwebadmin',
  $munki_web_admin_port= '8000',
  $time_zone   = 'America/Los_Angeles',
  $admin_name  = 'Munki Admin',
  $admin_email = 'munki@company.com',
  $admin_username  = 'munkiwebadmin',
  $admin_password= '123456',
) {

  unless $::osfamily == 'RedHat' {
    fail("Unsupported osfamily ${::osfamily}")
  }

  class{'munki_appliance::groups': } ->
  class{'munki_appliance::users': } ->
  class{'munki_appliance::software_repos': } ->
  class{'munki_appliance::install': } ->
  class{'munki_appliance::munki_vhost': } ->
  class{'munki_appliance::munki_dirs': } ->
  class{'munki_appliance::virtualenv': } ->
  class{'munki_appliance::mwa_install': } ->
  class{'munki_appliance::mwa_config': } ->
  class{'munki_appliance::mwa_vhost': } ->
  class{'munki_appliance::samba': } ->
  Class['munki_appliance']

}