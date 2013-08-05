# /etc/puppet/modules/munki_appliance/manifests/software_repos.pp

class munki_appliance::software_repos {

  if $::operatingsystem =~ /^(CentOS|RedHat)$/ {
    include 'epel'
  }

}