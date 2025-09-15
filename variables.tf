/*
  variables.tf
  Propósito: declarar variables usadas para el despliegue dinámico de Nginx.
  Estas variables permiten controlar cuántos contenedores Nginx levantar
  y el puerto base a partir del cual se publicarán.
*/

# Cantidad de contenedores Nginx a crear.
# Se usa para definir en un count o for_each en nginx.tf
variable "nginx_container_count" {
  type        = number
  description = "Número de contenedores Nginx que se desplegarán"
  default     = 1  # ejemplo de valor por defecto
}

# Puerto base a partir del cual se expondrán los contenedores Nginx en el host.
# Ejemplo: base 8080 => contenedores 8080, 8081, 8082...
variable "nginx_base_port" {
  type        = number
  description = "Puerto base para los contenedores Nginx"
  default     = 8080  # ejemplo de valor por defecto
}
