variable "network_name" {
  type        = string
  description = "El nombre de la vpc."
}

variable "network_routing_mode" {
  type        = string
  description = "El modo de routing a usar, [REGIONAL, GLOBAL]"
  default     = "REGIONAL"
}

variable "subnetwork_name" {
  type        = string
  description = "El nombre de la subred principal de la vpc."
}
variable "region" {
  type        = string
  description = "La región donde queda la subred principal de la vpc."
}

variable "ip_cidr_range_1" {
  type        = string
  description = "El rango de direcciones internas que pertenecen a la subred principal de la vpc."
}

variable "ip_cidr_range_2" {
  type        = string
  description = "El rango de direcciones internas que pertenecen a la subred de Cloud Run de la vpc."
}

variable "log_subnetwork" {
  type        = bool
  description = "Si se debe almacenar logs del trafico de la subred principal."
  default     = false
}

variable "filter_expr" {
  type        = string
  description = "Export filter used to define which VPC flow logs should be logged, as as CEL expression. See https://cloud.google.com/vpc/docs/flow-logs#filtering"
  default     = null
}

variable "vpc_peering" {
  type        = bool
  description = "Se requiere VPC perring para la red de una base de datos."
}
