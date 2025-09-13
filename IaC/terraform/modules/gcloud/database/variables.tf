variable "name" {
  type        = string
  description = "El nombre de la instancia."
}

variable "database_version" {
  type        = string
  description = "La versión a usar de la base de"
}

variable "region" {
  type        = string
  description = "La región donde queda la vpc"
}

variable "deletion_protection" {
  type        = bool
  description = "Si se debe proteger la base de datos de ser eliminada."
  default     = true
}

variable "availability_type" {
  type        = string
  description = "El tipo de disponibilidad de la instancia."
  default     = "ZONAL"
  # Possible values: ZONAL, REGIONAL
}

variable "disk_autoresize_limit" {
  type        = number
  description = "El maximo valor en GB que se permitira crecer al disco. Cuando es 0, no se establece limite."
  default     = 0
}

variable "tier" {
  type        = string
  description = "El tipo de maquina a utilizar para alocar la instancia."
}

variable "edition" {
  type        = string
  description = "La edición de la base de datos."
  default     = "ENTERPRISE" # Puede ser ENTERPRISE o ENTERPRISE_PLUS.
}

variable "private_network" {
  type        = string
  description = "La red privada a la que se conectara la instancia."
  default     = null
}

variable "reserved_peering_range" {
  type        = string
  description = "El rango de la red privada a la que se conectara la instancia."
  default     = null
}

variable "ssl_mode" {
  type        = string
  description = "El modo ssl para establecer conexiones."
  default     = "TRUSTED_CLIENT_CERTIFICATE_REQUIRED"
  # https://cloud.google.com/sql/docs/postgres/admin-api/rest/v1/instances#sslmode
}

variable "authorizednets" {
  type = list(object({
    name = string
    cidr = string
  }))
  description = "El conjunto de redes autorizadas para comunicarse con la DB."
}

variable "built_in_admin_user" {
  type        = string
  description = "El usuario tipo BUILT_IN que se crean con la base de datos."
  default     = null
}

variable "built_in_admin_password" {
  type        = string
  sensitive   = true
  description = "La contraseña del usuario tipo BUILT_IN que se crean con la base de datos."
  default     = null
}

variable "env" {
  type        = string
  description = "El entorno al que se le asigna la instancia sql."
}
