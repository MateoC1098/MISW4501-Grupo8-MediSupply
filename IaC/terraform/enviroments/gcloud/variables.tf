variable "project" {
  type        = string
  description = "El proyecto en gcloud al que se van a asociar todos los recursos"
  default     = "medisupply"
  sensitive   = false
}

variable "credentials_file" {
  type        = string
  description = "El archivo de credenciales del usuario con el que se realiza la configuración"
  default     = "../../../../.secure_files/MEDISUPPLY_TERRAFORM_ACCOUNT_KEY.json"
  sensitive   = true
}

# ssh-keygen -t ecdsa -b 521 -f key_medisupply_ecdsa -C "medisupply ssh key"
variable "gce_ssh_pub_key_file" {
  type        = string
  description = "Llave publica que se instala en las maquinas de la flota para poder ingresarlas por ssh."
  default     = "../../../../.secure_files/key_medisupply_ecdsa.pub"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "La región donde queda la subnet principal de la vpc"
  default     = "us-east1"
  sensitive   = false
}

variable "zone" {
  type        = string
  description = "La zona donde quedan las máquinas de la subnet principal de la vpc"
  default     = "us-east1-b"
  sensitive   = false
}

variable "dbadmin_password" {
  type        = string
  description = "La contraseña del usuario administrador de la base de datos."
  sensitive   = true
}
