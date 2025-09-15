/*
  main.tf
  Propósito: configuración inicial de Terraform y definición del proveedor Docker.
  Este archivo declara que se usará el provider de Docker (kreuzwerker/docker) y su versión.
*/

# Configuramos el proveedor de Docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Configuración del proveedor Docker:
# Por defecto se conecta al socket local de Docker (unix:///var/run/docker.sock).
