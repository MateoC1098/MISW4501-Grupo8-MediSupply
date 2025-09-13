#!/usr/bin/env python

import difflib
import os
import sys

import diff_match_patch as dmp_module
import gitlab
from gitlab.v4.objects import secure_files

dmp = dmp_module.diff_match_patch()

# import RESTObject

GITLAB_SERVER = os.environ.get('GL_SERVER', 'https://gitlab.com')
PROJECT_ID = os.environ.get('GL_PROJECT_ID', 74050874)
GITLAB_TOKEN = os.environ.get('GL_TOKEN')

if not GITLAB_TOKEN:
    print("Please set the GL_TOKEN env variable.")
    sys.exit(1)

gl = gitlab.Gitlab(GITLAB_SERVER, private_token=GITLAB_TOKEN)

# Main
project = gl.projects.get(PROJECT_ID)
remote_secure_files = project.secure_files.list(get_all=True)

directory: str = "../secure"
if not os.path.exists(directory):
    os.makedirs(directory)
set_names_en_carpeta: set[str] = set(os.listdir(directory))

set_names_en_linea = set()
secureFiles = {
    secure_file.name: secure_file for secure_file in remote_secure_files}
for secure_file in remote_secure_files:
    set_names_en_linea.add(secure_file.name)

for name in sorted(list(set_names_en_carpeta)):
    if name in set_names_en_linea:
        set_names_en_carpeta.remove(name)
        set_names_en_linea.remove(name)
        secure_file = secureFiles.get(name)
        content = secure_file.download()

        fullname = os.path.join(directory, name)

        with open(fullname, "rb") as f:
            local_content = f.read()

        if content == local_content:
            print(
                f"El archivo {name} NO ha cambiado.")
        else:
            print(
                f"El archivo {name} ha cambiado. Se le presentara la opcion de descargar la data remota(Dd) ó subir la data local(Uu)")
            diff = dmp.patch_make(str(content), str(local_content))
            patch = dmp.patch_toText(diff)
            print(patch)
            answer = "y"
            while answer.lower() != 'n' and answer.lower() != 'd' and answer.lower() != 'u':
                answer = input(
                    f"El archivo {name} ha cambiado, presione [Dd] para Descargar la data de GitLab, [Uu] para subir la data local ó [Nn] para no hacer nada.")
                if answer.lower() == 'd':
                    with open(f"../secure/{name}", "wb") as f:
                        secure_file.download(streamed=True, action=f.write)
                        print(f"Descargo:\t{name}")
                elif answer.lower() == 'u':
                    secure_file.delete()
                    secure_file = project.secure_files.create(
                        {"name": name, "file": open(f"../secure/{name}", "rb")}
                    )
                    print(f"Elimino y subio:\t{name}")

for name in sorted(list(set_names_en_carpeta)):
    answer = "y"
    while answer.lower() != 'n' and answer.lower() != 'u':
        answer = input(
            f"El archivo {name} no existe en GitLab, presione [Uu/Nn] para subir la data local.")
        if answer.lower() == 'n':
            break
        if answer.lower() == 'u':
            secure_file = project.secure_files.create(
                {"name": name, "file": open(f"../secure/{name}", "rb")}
            )
            print(f"Subio:\t{name}")

for secure_file in remote_secure_files:
    name = secure_file.name
    if name in set_names_en_linea:
        answer = "y"
        while answer.lower() != 'n' and answer.lower() != 'd':
            answer = input(
                f"El archivo {name} no existe localmente, presione [Dd/Nn] para Descargar la data de GitLab.")
            if answer.lower() == 'n':
                break
            elif answer.lower() == 'd':
                with open(f"../secure/{name}", "wb") as f:
                    secure_file.download(streamed=True, action=f.write)
                    print(f"Descargo:\t{name}")
