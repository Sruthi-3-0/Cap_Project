terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "docker" {}

# Pull the nginx:latest image
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Run a container with Nginx
resource "docker_container" "nginx_container" {
  name  = "nginx_container"
  image = docker_image.nginx.name   # ✅ THIS IS CORRECT

  ports {
    internal = 80
    external = 8080
  }
}
