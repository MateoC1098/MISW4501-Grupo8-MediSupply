variable "domain" {
  type        = string
  description = "Dominio que se va a administrar."
}

variable "a_records" {
  type = list(object({
    name = string
    ip   = string
  }))
  description = "Registros A que se van a configurar."
}

variable "cname_records" {
  type = list(object({
    name  = string
    alias = string
  }))
  description = "Registros CNAME que se van a configurar."
}
