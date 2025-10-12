terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.6.2"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.25.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock" # or "tcp://127.0.0.1:2375" on Windows if configured
}

provider "vault" {
  address = var.vault_addr
  token   = var.vault_token
}

# Docker container
resource "docker_container" "nginx_container" {
  name  = var.container_name
  image = var.docker_image

  ports {
    internal = 80
    external = 8080
  }
}

# Vault secret
resource "vault_kv_secret_v2" "mysecret" {
  path = "secret/mysecret"

  data_json = jsonencode({
    username = "admin"
    password = "newpassword123"
  })
}
