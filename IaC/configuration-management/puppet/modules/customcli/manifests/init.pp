# customcli class.
#
# A custom bash cli configuration:
#
# @example Declaring the class
#   include chatops
#
# @param users The users whom this configutation will be applied.
# @param icon The icon this user is going to display in his PS1.
class customcli (Array[String] $users, String $icon='🖥️') {
  $users.each | Integer $index, String $user | {
    if $user != 'root' {
      file { "/home/${$user}/.vimrc":
        source  => 'puppet:///modules/customcli/.vimrc',
        replace => true,
        mode    => '0644',
        owner   => $user,
        group   => $user,
      }

      file { "/home/${$user}/.puppetbashprofile.sh":
        ensure  => file,
        content => epp('customcli/bash-profile.sh.epp', {
            'icon' => $icon,
            'user' => $user,
        }),
        mode    => '0600',
        owner   => $user,
        group   => $user,
      }

      file_line { "Incluir bash profile para ${$user}":
        path    => "/home/${$user}/.bashrc",
        line    => 'if [ -f ~/.puppetbashprofile.sh ]; then source ~/.puppetbashprofile.sh; fi',
        require => File["/home/${$user}/.puppetbashprofile.sh"],
      }

      file { "/home/${$user}/.pythonrc.py":
        source  => 'puppet:///modules/customcli/.pythonrc.py',
        replace => true,
        mode    => '0644',
        owner   => $user,
        group   => $user,
      }

      file_line { "Incluir python startup para ${$user}":
        path    => "/home/${$user}/.bashrc",
        line    => 'if [ -f ~/.pythonrc.py ]; then export PYTHONSTARTUP=~/.pythonrc.py; fi',
        require => File["/home/${$user}/.pythonrc.py"],
      }
    } # fi
  } # rof
}
