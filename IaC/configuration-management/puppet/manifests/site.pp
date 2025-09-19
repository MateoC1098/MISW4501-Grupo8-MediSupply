node default {
  class { 'tools': arenero => false }

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
