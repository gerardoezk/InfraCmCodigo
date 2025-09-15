/*
  postgre.tf
  Propósito: descargar la imagen oficial de PostgreSQL y crear un contenedor
  conectado a la red de persistencia con las credenciales necesarias.
*/

# Descarga la imagen de PostgreSQL versión 15 en Alpine
resource "docker_image" "postgres" {
  name = "postgres:15-alpine" # nombre de la imagen en Docker Hub
}

# Crea el contenedor de PostgreSQL
resource "docker_container" "postgres" {
  image = docker_image.postgres.image_id           # usa la imagen descargada arriba
  name  = "postgres-${terraform.workspace}"        # nombre dinámico del contenedor (incluye workspace)

  # Conecta el contenedor a la red de persistencia para almacenamiento de datos
  networks_advanced {
    name = docker_network.persistence_net.name
  }

  # Expone el puerto estándar de PostgreSQL hacia el host
  ports {
    internal = 5432  # puerto interno del contenedor
    external = 5432  # puerto externo en el host (puedes parametrizarlo si necesitas)
  }

  # Variables de entorno para inicializar la base de datos:
  # - nombre de la base de datos
  # - usuario
  # - contraseña
  env = [
    "POSTGRES_DB=myapp",
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=password"
  ]
}
