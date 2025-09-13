#!/bin/bash

# Asegurar que el script esta siendo ejecutado como root.
# Ubicacion espérada de este script: /root/firewall.sh

if [[ "${UID}" -ne 0 ]]; then
  echo 'Por favor correr con sudo o como root.' >&2
  exit 1
fi

echo 'y' | ufw reset

ufw default deny incoming
ufw default allow outgoing

ufw allow in on lo
ufw allow from 127.0.0.1/8

ufw allow 22 # SSH Port
ufw allow from 35.235.240.0/20 to any port 3389 # allow-rdp-ingress-from-iap (gcloud ssh)
ufw allow 80 # http-server
ufw allow 443 # https-server

# Prender cuando ya tenga las reglas claras
echo 'y' | ufw enable # disable

ufw status numbered