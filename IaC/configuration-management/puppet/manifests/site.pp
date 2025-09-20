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
  $dbhost     = '10.241.0.2'

  $tunnels = [
    # user , ...tunnels, onlytunneling?, remoteforwarding?
    [$serviceuser, "${dbhost}:5432", 'true', 'false']
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
