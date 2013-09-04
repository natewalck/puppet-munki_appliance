# /etc/puppet/modules/munki_appliance/manifests/munki_vhost.pp

class munki_appliance::munki_vhost{
  $munki_root  = $munki_appliance::munki_root
  $munki_port  = $munki_appliance::munki_port
  $munki_user  = $munki_appliance::munki_user
  $munki_group = $munki_appliance::munki_group
  $ssl_enabled = $munki_appliance::ssl_enabled
  $ssl_cert    = $munki_appliance::ssl_cert
  $ssl_key     = $munki_appliance::ssl_key
  $mwa_port    = $munki_appliance::mwa_port

  apache::vhost { $::fqdn :
    port            => $munki_port,
    docroot         => $munki_root,
    docroot_owner   => $munki_user,
    docroot_group   => $munki_group,
    options         => ['-Indexes'],
    ssl             => $ssl_enabled,
    ssl_cert        => $ssl_cert,
    ssl_key         => $ssl_key,
    custom_fragment => template('munki_appliance/munkirewrites.erb'),
  }
}