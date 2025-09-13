variable "network_id" {
  type        = string
  description = "La red donde quedan las maquinas"
}

variable "ip_cidr_range_1" {
  type        = string
  description = "El rango de direcciones internas a las que se les va a permitir todo el trafico entre ellas."
}

variable "ip_cidr_range_2" {
  type        = string
  description = "El segundo rango de direcciones internas a las que se les va a permitir todo el trafico entre ellas."
}

variable "target_tag" {
  type        = string
  description = "El tag sobre el que se van a aplicar estas reglas de firewall."
}

variable "ssh_custom_port" {
  type        = string
  description = "El puerto al que se redirecciona sshd para evitar spam sobre las maquinas."
  default     = "56789"
}

variable "authorized_ingress_cidr_IPv4" {
  type        = list(string)
  description = "Las IPv4s desde donde se va poder acceder a las maquinas del proyecto."
  default     = []
}

variable "authorized_ingress_cidr_IPv6" {
  type        = list(string)
  description = "Las IPv6s desde donde se va poder acceder a las maquinas del proyecto."
  default     = []
}

variable "close_22_port" {
  type        = bool
  description = "Si se cierra el puerto 22 para evitar spam sobre las maquinas."
  default     = false
}

variable "open_custom_ssh_port" {
  type        = bool
  description = "Si se abre el puerto personalizado de ssh al internet publico."
  default     = false
}

variable "extra_dev_ports" {
  type        = list(string)
  description = "Los otros puertos que se habilitan para acceder desde las redes autorizadas, con el porposito de usarse en desarrollo."
  default     = []
}

