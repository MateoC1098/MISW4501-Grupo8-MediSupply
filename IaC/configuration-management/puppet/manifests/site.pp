node default {
  exec { 'timezone-Bogota':
    path    => ['/usr/bin', '/usr/sbin', '/bin'],
    unless  => "timedatectl status | grep 'Time zone:.*America/Bogota.*'",
    command => 'timedatectl set-timezone America/Bogota',
  }

  exec { 'key-map-latam-layout':
    path    => ['/usr/bin', '/usr/sbin', '/bin'],
    unless  => "localectl status | grep 'X11.*latam'",
    command => 'localectl set-x11-keymap latam',
  }

  class { 'tools': arenero => false }

  package { ['curl', 'htop', 'openssh-server', 'postgresql-client', 'tcpdump']:
    ensure => latest,
  }

  class { 'customufw':
    sshport             => '22',
    authorizednettworks => [],
    authorizedports     => [],
    serverhttp          => true,
    serverhttps         => true,
    gcloud              => true,
  }

  $serviceuser = 'ubuntu'
  $tunnels = [
    # user , ...tunnels, onlytunneling?, remoteforwarding?
    [$serviceuser, 'localhost:5432', 'true', 'false']
  ]
  class { 'sshhardening':
    port             => 22,
    running          => true,
    addressestunnels => [],
    tunnels          => $tunnels,
    superuser        => $serviceuser,
  }

  class { 'customcli':
    users => [$serviceuser],
    icon  => '🛰️',
  }
}
