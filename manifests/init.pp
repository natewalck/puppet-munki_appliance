# /etc/puppet/modules/munki_appliance/manifests/init.pp
class munki_appliance(
  $munki_root  = '/var/www/munki',
  $munki_port  = '80',
  $munki_user  = 'munki',
  $munki_group = 'munki',
  $munki_web_admin_user  = 'munkiwebadmin',
  $munki_web_admin_dir   = '/opt/munkiwebadmin_env',
  $munki_web_admin_data  = '/etc/munkiwebadmin',
) {

  class{'munki_appliance::groups': } ->
  class{'munki_appliance::users': } ->
  class{'munki_appliance::repos': } ->
  class{'munki_appliance::install': } ->
  class{'munki_appliance::virtualenv': } ->
  class{'munki_appliance::config': } ->
  class{'munki_appliance::vhosts': } ->
  Class['munki_appliance']

}