/*
  nginx.tf
  Propósito: descargar la imagen oficial de Nginx y crear varios contenedores
  conectados a las redes Docker definidas, exponiendo sus puertos de manera incremental.
*/

# Descarga la imagen de Nginx (versión estable Alpine con Perl)
resource "docker_image" "nginx" {
  name         = "nginx:stable-alpine3.21-perl" # nombre de la imagen en Docker Hub
  keep_locally = false                         # no conservar localmente la imagen tras la destrucción del recurso
}

# Crea N contenedores Nginx según el valor de var.nginx_container_count
resource "docker_container" "nginx" {
  count = var.nginx_container_count  # cuántos contenedores Nginx levantar

  # Nombre dinámico del contenedor, incluye el workspace y un índice (+1 para empezar en 1)
  name  = "app-${terraform.workspace}-${count.index + 1}"

  # Usa la imagen descargada en el recurso anterior
  image = docker_image.nginx.image_id

  # Conectar el contenedor a la red de aplicación
  networks_advanced {
    name = docker_network.app_net.name
  }

  # Conectar también el contenedor a la red de persistencia
  networks_advanced {
    name = docker_network.persistence_net.name
  }

  # Exponer puerto 80 interno del contenedor a un puerto externo incremental:
  # Ejemplo: base 8080 y 3 contenedores → 8080, 8081, 8082
  ports {
    internal = 80
    external = var.nginx_base_port + count.index
  }
}
