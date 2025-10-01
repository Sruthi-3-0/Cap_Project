terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Vault provider reads token from environment variable
provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = "root"
}

# Fetch secret from Vault
data "vault_generic_secret" "mysecret" {
  path = "secret/mysecret"
}

# Pull the nginx:latest image
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Run a container with Nginx and Vault secrets as env
resource "docker_container" "nginx_container" {
  name  = var.container_name
  image = docker_image.nginx.name

  ports {
    internal = 80
    external = var.external_port
  }

  env = [
    "APP_USERNAME=${data.vault_generic_secret.mysecret.data["username"]}",
    "APP_PASSWORD=${data.vault_generic_secret.mysecret.data["password"]}"
  ]
}
