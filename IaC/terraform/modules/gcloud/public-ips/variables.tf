variable "project" {
  type        = string
  description = "El proyecto en gcloud al que se van a asociar todos los recursos"
}

variable "region" {
  type        = string
  description = "La región donde se separan las IPs."
}

variable "expected_ips" {
  type = list(object({
    name        = string
    description = string
    env         = string
  }))
  description = "El conjunto de IP publicas a separar para el proyecto."
}
