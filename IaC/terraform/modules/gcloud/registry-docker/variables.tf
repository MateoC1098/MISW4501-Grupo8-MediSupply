variable "project" {
  type        = string
  description = "El name del proyecto en gcloud al que se van a asociar todos los recursos"
  sensitive   = false
}

variable "location" {
  type        = string
  description = "La región donde queda el artifact registry"
  sensitive   = false
}

variable "repository_id" {
  type        = string
  description = "Id del docker registry a crear."
}

variable "description" {
  type        = string
  description = "Descripción asociada al registry."
}

variable "env" {
  type        = string
  description = "El entorno al que se le asigna el registry."
}
