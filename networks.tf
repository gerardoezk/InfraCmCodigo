/*
  networks.tf
  Propósito: definir las redes Docker necesarias para aislar las distintas capas
  de la infraestructura (aplicación, persistencia y monitoreo).
  Cada red utiliza el driver "bridge" para la comunicación entre contenedores.
*/

# Red para la capa de aplicación (servicios web, Nginx, etc.)
resource "docker_network" "app_net" {
  name   = "app_net"  # nombre de la red en Docker
  driver = "bridge"   # tipo de red
}

# Red para la capa de persistencia (bases de datos, almacenamiento)
resource "docker_network" "persistence_net" {
  name   = "persistence_net"
  driver = "bridge"
}

# Red para la capa de monitoreo (Grafana, Prometheus, etc.)
resource "docker_network" "monitor_net" {
  name   = "monitor_net"
  driver = "bridge"
}
