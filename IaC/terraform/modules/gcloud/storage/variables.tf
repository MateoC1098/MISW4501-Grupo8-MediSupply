variable "project" {
  type        = string
  description = "El proyecto en gcloud al que se van a asociar todos los recursos"
}

variable "region" {
  type        = string
  description = "La región donde queda el storage bucket"
}

variable "storage_bucket_name" {
  type        = string
  description = "El nombre del bucket de almacenamiento"
}
