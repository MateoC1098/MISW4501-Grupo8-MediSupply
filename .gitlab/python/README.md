# Automatización de Gitlab con Python (lib: python-gitlab)

> Ejecutar scripts en la linea de comandos desde esta carpeta.

## Workflow multiplataforma

### Primera vez, instalacion de dependencias

#### Windows

[python y pip](https://www.python.org/downloads/windows/)

> - Usar privilegios de administrador instalando py.exe
> - Instalar pip
> - Deshabilitar el limite de tamaño del PATH si es necesario
> - Agregar python.exe al PATH

#### Ubuntu/debian

```bash
# ============================= Ubuntu/Debian =============================
# [Primera vez] Instalar modulo pip para el manejo de dependencias globales
sudo apt install python3-pip
# Los modulos que se descargan con pip caen en ~/.local/bin.
# Puede que toque agregarlo al PATH. Con esto se arrglaria:
echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> ~/.bashrc
```

### Workflow normal

> python3 en Linux

```sh
# ============================= Multiplataforma ===========================
# [Primera vez] Instalar modulo pipenv para el manejo de entornos virtuales
pip install pipenv

# Activar el entorno
pipenv shell
# O sin pipenv:
python3 -m venv ./.venv
source ./.venv/bin/activate

# Trabajar (requiere: Activar el entorno)
# Instala las dependencias en el entorno
pipenv install
# O sin pipenv:
pip3 install -r requirements.txt

# Ejecuta la aplicación
python3 src/secure_files_sync.py

# Desactivar el entorno (requiere: Activar el entorno)
deactivate # También sirve: Ctrl + d
```

## Casos de uso locales

> python3 en Linux

### Crear el CHANGELOG.md del repositorio

```bash
export PYTHONIOENCODING=utf-8
python src/create_changelog_from_git_history.py | tee ../../CHANGELOG.md
# Luego se debe hacer cumplir al reporte con el estandar de codificación del equipo.
# npx prettier --write ../../CHANGELOG.md
```

### Sincronizar los secure_files entre la carpeta local "secure" y el secure_files de GitLab.

```bash
python src/secure_files_sync.py
```

## Ejecutar un contenedor de desarrollo

Esto sirve para preparar un contenedor con las dependencias necesarias para ejecutar el desarrollo en python.

En este contenedor de desarrollo las carpeta src y tests se montan a traves de volumenes para que los cambios que se hagan en el editor se vean reflejados en el contenedor.

```bash
# docker build: Construye una imagen
# -t: Tag
docker build . -t python-gitlab-automation

# docker images: Lista las imagenes
docker images

# docker run: Ejecuta un contenedor
# -t: TTY
# -d: Detached
# -i: Interactive
# -e: Environment variable
# -v: Volume
# --name: Container name

# Linux
docker run -tde "GL_TOKEN=${GL_TOKEN}" \
-v "${PWD}/src:/home/devops/src" -v "${PWD}/secure:/home/devops/secure" \
--name python-gitlab-automation python-gitlab-automation

# Windows (Git Bash)
docker run -tde "GL_TOKEN=${GL_TOKEN}" \
-v "/${PWD}/src:/home/devops/src" -v "/${PWD}/secure:/home/devops/secure" \
--name python-gitlab-automation python-gitlab-automation

# docker ps: Lista los contenedores
docker ps

# docker exec: Inicializa una consola interactiva en un contenedor
docker exec -ti python-gitlab-automation bash
```

## Ejecutar scripts en un contenedor

Esto sirve para preparar un contenedor con las dependencias necesarias para ejecutar los scripts en el pipeline de Gitlab.

```bash
# docker build: Construye una imagen
# -t: Tag
docker build . -t python-gitlab-automation

# docker images: Lista las imagenes
docker images

# docker run: Ejecuta un contenedor
# -t: TTY
# -d: Detached
# -i: Interactive
# -e: Environment variable
# -v: Volume
# --name: Container name

# Linux
docker run -tde "GL_TOKEN=${GL_TOKEN}" \
-v "${PWD}/src:/home/devops/src" -v "${PWD}/secure:/home/devops/secure" \
--name python-gitlab-automation python-gitlab-automation

# Windows
docker run -tde "GL_TOKEN=${GL_TOKEN}" \
-v "/${PWD}/src:/home/devops/src" -v "/${PWD}/secure:/home/devops/secure" \
--name python-gitlab-automation python-gitlab-automation

# docker ps: Lista los contenedores
docker ps

# docker exec: Ejecuta un comando en un contenedor
# Linux
docker exec -ti python-gitlab-automation python /home/devops/src/create_changelog_from_git_history.py
# Windows
docker exec -ti python-gitlab-automation python //home/devops/src/create_changelog_from_git_history.py
```

## Referencias

- [Efficient DevSecOps workflows: Hands-on python-gitlab API automation](https://about.gitlab.com/blog/2023/02/01/efficient-devsecops-workflows-hands-on-python-gitlab-api-automation/)
- [Python Gitlab Examples](https://gitlab.com/gitlab-de/use-cases/gitlab-api/gitlab-api-python)
- [Python Gitlab](https://python-gitlab.readthedocs.io/en/stable/index.html)
- [Python Gitlab API](https://python-gitlab.readthedocs.io/en/stable/api-usage.html)
