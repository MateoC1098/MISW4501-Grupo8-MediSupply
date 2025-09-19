#!/bin/bash

# Ejecutar script desde esta carpeta
# Asegurar que el script esta siendo ejecutado como root.
if [[ "${UID}" -ne 0 ]]; then
  echo 'Por favor correr con sudo o como root.' >&2
  exit 1
fi

USAGE="Usage: $0 [-l] [-h]"

CYAN=$(tput setaf 6)
RESET=$(tput sgr0)
BOLD=$(tput bold)

function asksure() {
    echo "${BOLD}${CYAN}[$(date +'%F %T')]: $1 (Yy/Nn)${RESET}"
    while read -r answer; do
        if [[ $answer = [YyNn] ]]; then
            [[ $answer = [Yy] ]] && retval=0
            [[ $answer = [Nn] ]] && retval=1
            break
        fi
        echo "${BOLD}${CYAN}[$(date +'%F %T')]: $1 (Yy/Nn)${RESET}"
    done

    return ${retval}
}

LOCAL_EXECUTION=false

function getoptions() {
    while getopts "hl" option; do
        case "${option}" in
            h)
                echo "${USAGE}"
                exit 0
                ;;
            l)
                LOCAL_EXECUTION=true
                ;;
            *)
                echo "${USAGE}" 1>&2
                exit 1 
                ;;
        esac
    done
    shift $((OPTIND-1))
}

function main () {
    if asksure "¿Se debe instalar puppet8 & node y actualizar el repositorio de postgres?"; then
        local HAS_TO_UPDATE=false

        apt-get update
        apt-get -y upgrade 
        apt-get -y autoremove

        if ! command -v curl &> /dev/null; then apt-get -y install curl; fi
        if ! command -v gpg &> /dev/null; then apt-get -y install gpg; fi
        if ! command -v wget &> /dev/null; then apt-get -y install wget; fi
        if ! command -v lsb_release &> /dev/null; then apt-get -y install lsb_release; fi
        if ! command -v software-properties-common &> /dev/null; then apt-get -y install software-properties-common; fi
        apt-get -y install ca-certificates       

        DISTRO="$(lsb_release -cs)"
        if lsb_release -i | grep -i 'debian\|trixie'; then DISTRO="bookworm"; fi

        if ! command -v node &> /dev/null; then  
            curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
            HAS_TO_UPDATE=true
        fi

        if [ "${LOCAL_EXECUTION}" = true ]; then
            if ! command -v code &> /dev/null; then
                wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
                install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
                echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list
                rm -f packages.microsoft.gpg
                HAS_TO_UPDATE=true
            fi

            if ! command -v terraform &> /dev/null; then
                wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
                echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com ${DISTRO} main" | tee /etc/apt/sources.list.d/hashicorp.list
                HAS_TO_UPDATE=true
            fi

            if ! command -v gcloud &> /dev/null; then
                curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
                echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list
                HAS_TO_UPDATE=true
            fi

            if ! command -v docker &> /dev/null; then
                # In releases older than Debian 12 and Ubuntu 22.04, folder /etc/apt/keyrings does not exist by default, and it should be created before the curl command.
                if [ ! -d /etc/apt/keyrings ]; then mkdir -p -m 755 /etc/apt/keyrings; fi

                curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
                chmod a+r /etc/apt/keyrings/docker.asc

                # Add the repository to Apt sources:
                echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian ${DISTRO} stable" | \
                tee /etc/apt/sources.list.d/docker.list > /dev/null

                HAS_TO_UPDATE=true
            fi

            if ! command -v kubectl &> /dev/null; then
                # In releases older than Debian 12 and Ubuntu 22.04, folder /etc/apt/keyrings does not exist by default, and it should be created before the curl command.
                if [ ! -d /etc/apt/keyrings ]; then mkdir -p -m 755 /etc/apt/keyrings; fi

                curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
                # allow unprivileged APT programs to read this keyring
                chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg

                echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
                # helps tools such as command-not-found to work correctly
                chmod 644 /etc/apt/sources.list.d/kubernetes.list
                HAS_TO_UPDATE=true
            fi

            if ! [ -f /usr/pgadmin4/bin/pgadmin4 ]; then
                curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
                echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/${DISTRO} pgadmin4 main" | tee /etc/apt/sources.list.d/pgadmin4.list
                HAS_TO_UPDATE=true
            fi

            if ! command -v dbeaver-ce &> /dev/null; then
                wget -O /usr/share/keyrings/dbeaver.gpg.key https://dbeaver.io/debs/dbeaver.gpg.key
                echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" | tee /etc/apt/sources.list.d/dbeaver.list
                HAS_TO_UPDATE=true
            fi

            if lsb_release -i | grep -i 'ubuntu' && ! command -v R &> /dev/null; then
                wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
                add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
                add-apt-repository ppa:c2d4u.team/c2d4u4.0+
                HAS_TO_UPDATE=true
            fi

            if test -d /home/vagrant && lsb_release -i | grep -i 'debian' && ! grep -q "^deb http://deb.debian.org/debian/ sid main contrib non-free non-free-firmware # Debian Unstable Sid$" /etc/apt/sources.list; then
                echo 'deb http://deb.debian.org/debian/ sid main contrib non-free non-free-firmware # Debian Unstable Sid' >> /etc/apt/sources.list
                HAS_TO_UPDATE=true
            fi
        fi # LOCAL_EXECUTION

        if ! command -v puppet &> /dev/null; then
            wget https://apt.puppet.com/puppet8-release-jammy.deb
            apt-get -y install ./puppet8-release-jammy.deb
            rm -f ./puppet8-release-jammy.deb
            apt-get update
            HAS_TO_UPDATE=false
            if [ "${LOCAL_EXECUTION}" = true ]; then 
                apt-get -y install puppet puppet-bolt
            else
                apt-get -y install puppet
            fi 

            # Add /opt/puppetlabs/bin to the secure_path in the /etc/sudoers file (By hand)
            # visudo (As root)
            # Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/opt/puppetlabs/bin"
            if grep -q "^Defaults.*secure_path=.*:/opt/puppetlabs/bin.*$" /etc/sudoers; then
                echo "/opt/puppetlabs/bin is already in the secure_path"
            else
                sed -i.bak 's#secure_path="\(.*\)"#secure_path="\1:/opt/puppetlabs/bin"#' /etc/sudoers
                echo "/opt/puppetlabs/bin added to the secure_path"
            fi
        fi

        if [ "${HAS_TO_UPDATE}" = true ]; then apt-get update; fi

        if [ "${LOCAL_EXECUTION}" = true ]; then
            if command -v flatpak &> /dev/null; then
                flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
                if ! (flatpak list --app | grep -i telegram); then
                    flatpak install -y --noninteractive flathub org.telegram.desktop
                fi
            fi
        fi # LOCAL_EXECUTION

    fi

    if asksure "¿Se debe instalar los modulos externos de Puppet forge?"; then
        # Instrall supported modules
        puppet module install puppetlabs-stdlib --version 9.6.0
        puppet module install puppetlabs-apt --version 9.4.0
        puppet module install puppetlabs-docker --version 9.1.0
        puppet module install puppetlabs-vcsrepo --version 6.1.0
        puppet module install puppetlabs-sshkeys_core --version 2.5.0
    fi

    local retval=0
    local OLD_PATH="$(puppet config print modulepath)"
    local code_location=$(test ${LOCAL_EXECUTION} = true && echo '' || echo 'puppet/')

    if asksure "¿Quiere previsualizar el catalogo de cambios?"; then
        puppet apply "${code_location}manifests/site.pp" --test --noop --detailed-exitcodes --modulepath "${OLD_PATH}:${code_location}modules"
        retval=$?
        echo "0: The run succeeded with no changes or failures; the system was already in the desired state."
        echo "1: The run failed."
        echo "2: The run succeeded, and some resources were changed."
        echo "4: The run succeeded, and some resources failed."
        echo "6: The run succeeded, and included both changes and failures."
        echo "============================================================="
        echo "Puppet noop exit code: ${retval}"

        if [ ${retval} -ne 0 ] && [ ${retval} -ne 2 ]; then
            return ${retval}
        fi
    fi

    if asksure "¿Quiere proceder con aplicar el catalogo de cambios?"; then
        puppet apply "${code_location}manifests/site.pp" --detailed-exitcodes --modulepath "${OLD_PATH}:${code_location}modules"
        retval=$?
        echo "0: The run succeeded with no changes or failures; the system was already in the desired state."
        echo "1: The run failed."
        echo "2: The run succeeded, and some resources were changed."
        echo "4: The run succeeded, and some resources failed."
        echo "6: The run succeeded, and included both changes and failures."
        echo "============================================================="
        echo "Puppet exit code: ${retval}"

        if [ ${retval} -ne 0 ] && [ ${retval} -ne 2 ]; then
            return ${retval}
        fi
    fi

    return 0
}

getoptions "$@"
main
