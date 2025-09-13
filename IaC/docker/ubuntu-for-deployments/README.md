# Contenedor para correr los despliegues

Este contenedor basado en Ubuntu:22.04 busca contener las dependencias necesarias para el proceso de despliegue y gestion de las maquinas.

```bash
# docker build: Construye una imagen
# -t: Tag
docker build --build-arg PORT=56789 -t ubuntu-for-deployments .

# docker images: Lista las imagenes
docker images

# docker run: Ejecuta un contenedor
# -t: TTY
# -d: Detached
# -i: Interactive
# -e: Environment variable
# -v: Volume
# --name: Container name

docker run -td --name ubuntu-for-deployments ubuntu-for-deployments

# docker ps: Lista los contenedores
docker ps

# docker exec: Inicializa una consola interactiva en un contenedor
docker exec -ti ubuntu-for-deployments bash
```
