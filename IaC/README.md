# Infraestructura

## Set Up Google Cloud Platform

Secuencias de comandos que se deben preparar para el proyecto:

```bash
# Configura la region y zona del proyecto
gcloud config set project medisupply
gcloud config set compute/region us-east1
gcloud config set compute/zone us-east1-a
```

El proyecto debe de tener habilitadas las siguientes APIs:

```bash
gcloud services enable compute.googleapis.com
gcloud services enable servicenetworking.googleapis.com
gcloud services enable sqladmin.googleapis.com
gcloud services enable dns.googleapis.com
gcloud services enable artifactregistry.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable pubsub.googleapis.com
gcloud services enable redis.googleapis.com
gcloud services enable apigateway.googleapis.com
gcloud services enable vpcaccess.googleapis.com
gcloud services enable run.googleapis.com
```

El proyecto tambien necesita de las cuentas de servicios:

- vms-account@medisupply.iam.gserviceaccount.com (Solo con persmisos de monitoreo)
- terraform@medisupply.iam.gserviceaccount.com (Con persmisos de editor)

```bash
# Permisos aicionales para la cuanta de servicio de terraform@medisupply.iam.gserviceaccount.com
gcloud projects add-iam-policy-binding medisupply --member="serviceAccount:terraform@medisupply.iam.gserviceaccount.com" --role="roles/servicenetworking.networksAdmin"
gcloud projects add-iam-policy-binding medisupply --member="serviceAccount:terraform@medisupply.iam.gserviceaccount.com" --role="roles/compute.networkAdmin"
gcloud projects add-iam-policy-binding medisupply --member="serviceAccount:terraform@medisupply.iam.gserviceaccount.com" --role="roles/compute.securityAdmin"
```

===

## Comandos auxiliares

```bash
# Para encontra la version de ubuntu mas reciente ubuntu-2404-lts-amd64
gcloud compute images list --project=ubuntu-os-cloud   --filter="name~'ubuntu-2404-noble'"
```

```bash
chmod 764 Firewall.sh
sudo ./Firewall.sh
```

Firewall.sh

```bash
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
```

## Tareas pendientes

```txt
Instructions

Entregar un archivo de PDF que incluye los enlaces a los documentos y evidencias correspondientes a:

- Informe de avance de la ejecución de los experimentos de arquitectura sobre validación atributos de calidad
- Avance del prototipo  (mockup) web/móvil.
- Actualización del documento de arquitectura (si aplica)
- Actualización del plan de trabajo y tablero.
- Video con evidencias.

Realizar la entrega de la semana de acuerdo a las indicaciones del video y teniendo en cuenta los elementos que serán evaluados a partir de los criterios a continuación:

1.      Avance de la ejecución de los experimentos de arquitectura sobre validación de ASR (30 puntos)

Avance en la ejecución de los experimentos que se realizaron para la validación de los ASR (15 puntos)

Avance del análisis de resultados y justificación de las decisiones de diseño frente a los ASR, indicando aquellas decisiones que merecen ser corregidas y/o revisadas. (15 puntos)

 2.      Avances del prototipo versión web/móvil  (40 puntos)

Avance de la versión web que incluye navegación a la funcionalidad definida (15 puntos)

Avance de la versión móvil que incluye navegación sobre la funcionalidad definida (15 puntos)

Implementación de condiciones de usabilidad (Accesibilidad, Localización, Internacionalización) (10 puntos)

 3.      Documento de arquitectura ajustado (10 Puntos)

Modelos de arquitectura y diseño ajustados conforme a los resultados de experimentación (10 puntos)

 4.      Plan de trabajo y tablero (10 puntos)

Se evidencia actualización del plan de trabajo y tablero en la plataforma seleccionada por el equipo (Azure DevOps, Jira, Otro)

 5.      Video con evidencias  (10 puntos)

Se entrega video con evidencias (10 puntos
```
