variable "sufix" {
  type        = string
  description = "Sufijo con el que se decora el nombre del despliegue de parches en el proyecto."
}

variable "instances_URIs" {
  type        = list(string)
  description = "Listado de instancias a las que se aplicaran los parches."
}

variable "pre_step_script_path" {
  type        = string
  description = "Ruta donde se puede encontrar el script que correra previo a la aplicación del parche."
}

variable "post_step_script_path" {
  type        = string
  description = "Ruta donde se puede encontrar el script que correra posterior a la aplicación del parche."
}
