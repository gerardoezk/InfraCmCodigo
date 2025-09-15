/*
  grafana.tf
  Propósito: descargar la imagen oficial de Grafana Enterprise y levantar
  un contenedor conectado tanto a la red de monitoreo como a la de aplicación.
  Grafana es la herramienta de visualización/monitorización de métricas.
*/

# Descarga la imagen de Grafana Enterprise versión 9.4.7
resource "docker_image" "grafana" {
  name         = "grafana/grafana-enterprise:9.4.7" # nombre y versión de la imagen
  keep_locally = false                              # no mantener la imagen local tras destruir el recurso
}

# Crea el contenedor de Grafana
resource "docker_container" "grafana" {
  image = docker_image.grafana.image_id              # usa la imagen descargada arriba
  name  = "grafana-${terraform.workspace}"           # nombre dinámico del contenedor

  # Conecta Grafana a la red de monitoreo
  networks_advanced {
    name = docker_network.monitor_net.name
  }

  # Conecta también Grafana a la red de aplicación si necesita acceder a servicios
  networks_advanced {
    name = docker_network.app_net.name
  }

  # Expone el puerto web de Grafana en el host (por defecto 3000)
  ports {
    internal = 3000  # puerto interno del contenedor
    external = 3000  # puerto externo en el host
  }

  # Configura reinicio automático para asegurar disponibilidad
  restart = "always"
}
