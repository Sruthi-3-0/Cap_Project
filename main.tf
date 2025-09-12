terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Pull the latest Nginx image
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Run an Nginx container
resource "docker_container" "nginx_container" {
  name  = "nginx_container"
  image = docker_image.nginx.name
  ports {
    internal = 80
    external = 8080
  }
}
