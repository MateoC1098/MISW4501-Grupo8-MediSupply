# tools class.
#
# Very usefulls packages to have instaled across all the fleet machines and keyboard and timedate setup acording to Bogotá.
#
# @example Declaring the class
#   include tools

# @param arenero The machine run as a sandbox.
# @param localees The machine run as a sandbox.
class tools (Boolean $arenero=true, Boolean $localees=true) {
  $packages_common = [
    'coreutils','git', 'curl', 'htop', 'unzip', 'tree', 'plocate', 'openssh-server',
    'vim', 'neovim', 'vim-puppet',
    'whois', 'net-tools', 'tcpdump', 'traceroute', 'nmap',
    'nginx', 'python3', 'certbot', 'python3-certbot-nginx',
    'nodejs', 'postgresql-client', 'stress',
    'lsb-release', 'gpg',
  ]

  $packages_arenero = ['baobab']

  $ensure_packages = $arenero ? {
    true => 'latest',
    false => absent
  }

  package { $packages_common:
    ensure => 'latest',
  }

  package { $packages_arenero:
    ensure => $ensure_packages,
  }

  exec { 'timezone-Bogota':
    path    => ['/usr/bin', '/usr/sbin', '/bin'],
    unless  => "timedatectl status | grep 'Time zone:.*America/Bogota.*'",
    command => 'timedatectl set-timezone America/Bogota',
  }

  # Dejar de pasar las máquinas a español
  # if $localees {
  #   exec { 'set-locale-es_CO':
  #     path    => ['/usr/bin', '/usr/sbin', '/bin'],
  #     unless  => "localectl status | grep 'System Locale: LANG=es_CO.UTF-8",
  #     command => 'locale-gen es_CO.UTF-8 && localectl set-locale LANG=es_CO.UTF-8',
  #   }
  # } # fi
}
