# customufw class.
#
# A custom module for the machine firewall using ufw.
#
# @example Declaring the class
#   include customufw
#
# @param sshport 
# @param authorizednettworks 
# @param authorizedports 
# @param serverhttp 
# @param serverhttps 
# @param gcloud
class customufw (String $sshport, Array[String] $authorizednettworks= [], Array[String] $authorizedports= [],
Boolean $serverhttp=true, Boolean $serverhttps=true, Boolean $gcloud=true) {
  package { 'ufw': ensure => 'latest' }

  file { '/root/firewall.sh':
    ensure  => file,
    content => epp('customufw/firewall.sh.epp', {
        'sshport'             => $sshport,
        'authorizednettworks' => $authorizednettworks,
        'authorizedports'     => $authorizedports,
        'serverhttp'          => $serverhttp,
        'serverhttps'         => $serverhttps,
        'gcloud'              => $gcloud
    }),
    mode    => '0744',
    owner   => 'root',
    group   => 'root',
  }

  exec { 'Correr Firewall':
    path        => ['/usr/bin', '/usr/sbin', '/bin'],
    command     => '/bin/bash /root/firewall.sh',
    subscribe   => File['/root/firewall.sh'],
    refreshonly => true,
  }
}
