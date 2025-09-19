variable "sufix" {
  type        = string
  description = "Sufijo con el que se decora el nombre de la politica de recursos."
}

variable "region" {
  type        = string
  description = "Región donde se deja la politica de recursos."
}

variable "start_schedule" {
  type        = string
  description = "Horario de prendido de la maquina en fromato cron."
}

variable "stop_schedule" {
  type        = string
  description = "Horario de apagado de la maquina en fromato cron."
}
