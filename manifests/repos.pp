# /etc/puppet/modules/munki_appliance/manifests/repos.pp

class munki_appliance::repos {

  if $::operatingsystem =~ /^(CentOS|RedHat)$/ {
    include 'epel'
  }

}