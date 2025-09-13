# sshhardening class.
#
# A group of rules for hardening the sshd.service:
#
# @example Declaring the class
#   include sshhardening
#
# @param port for sshd.
# @param running Whether the ssh service should be running.
# @param addressestunnels Addresses allowed to connect to the ssh tunnels (example: ['190.158.209.2'])
# @param tunnels Local tunnels allowed for the users, second last is if is an only tunnels conections, last field is if remote fordwarding 
# is allowed
# example: [['henry.delaossa', '35.231.80.165:5432', 'false', 'true']]
# @param superuser an user that will be able to use all kinds of tunnels.
class sshhardening (Integer $port, Boolean $running,
Array[String] $addressestunnels, Array[Array[String]] $tunnels, String $superuser) {
  file { '/etc/ssh/sshd_config':
    ensure  => file,
    content => epp('sshhardening/sshd_config.epp', {
        'port'             => $port,
        'addressestunnels' => $addressestunnels,
        'tunnels'          => $tunnels,
        'superuser'        => $superuser
    }),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => Service['ssh'],
  }

  file { '/var/run/sshd/':
    ensure  => 'directory',
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    require => File['/etc/ssh/sshd_config'],
  }

  service { 'ssh':
    ensure  => $running,
    enable  => $running,
    restart => true,
  }
}
