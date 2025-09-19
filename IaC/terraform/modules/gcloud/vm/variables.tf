variable "gce_ssh_pub_key_file" {
  type        = string
  description = "Llave publica que se instala en las maquinas de la flota para poder ingresarlas por ssh."
  sensitive   = true
}

variable "region" {
  type        = string
  description = "La region donde queda la vpc"
}

variable "zone" {
  type        = string
  description = "La zona donde queda la vpc"
}

variable "network_id" {
  type        = string
  description = "La red donde quedan las maquinas"
}

variable "subnetwork_id" {
  type        = string
  description = "La subred donde quedan las maquinas"
}

variable "vms_account_id" {
  type        = string
  description = "La cuenta de servicio que va a ir asociada a las máquinas virtuales."
}

variable "name" {
  type = string
}

variable "diskname" {
  type        = string
  description = "El nombre del disco de la máquina."
  default     = null
}

variable "machine_type" {
  type = string
}

variable "tags" {
  type = list(string)
}

variable "size" {
  type = number
}

variable "type" {
  type = string
}

variable "network_ip" {
  type = string
}

variable "cidr" {
  type = string
}

variable "delete_boot_disk" {
  type = bool
}

variable "resource_policies" {
  type = list(string)
}

variable "metadata_startup_script" {
  type = string
}

variable "image" {
  type = string
}

variable "source_snapshot" {
  type = list(string)
}

variable "enable_snapshot_policy" {
  type = bool
}

variable "snapshot_start_time" {
  type = string
}

variable "env" {
  type        = string
  description = "El entorno al que se le asigna la vm."
}

variable "deletion_protection" {
  type        = bool
  description = "Si se protege una instancia de su eliminación."
  default     = false
}
