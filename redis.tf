/*
  redis.tf
  Propósito: descargar la imagen oficial de Redis y levantar un contenedor
  conectado a la red de persistencia para caching/almacenamiento en memoria.
*/

# Descarga la imagen de Redis versión 7.4.1 en Alpine
resource "docker_image" "redis" {
  name = "redis:7.4.1-alpine" # nombre y versión de la imagen
}

# Crea el contenedor de Redis
resource "docker_container" "redis" {
  name  = "redis-${terraform.workspace}"     # nombre dinámico del contenedor
  image = docker_image.redis.image_id        # usa la imagen descargada arriba

  # Conecta Redis a la red de persistencia
  networks_advanced {
    name = docker_network.persistence_net.name
  }

  # Expone el puerto estándar de Redis hacia el host
  ports {
    internal = 6379  # puerto interno del contenedor
    external = 6379  # puerto externo en el host
  }

  # Reinicio automático para asegurar disponibilidad
  restart = "always"
}
