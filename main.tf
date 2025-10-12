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
  # Use Unix socket on Linux/macOS; on Windows, configure Docker TCP if needed
  host = "unix:///var/run/docker.sock"
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

# Vault KV v2 secret
resource "vault_kv_secret_v2" "mysecret" {
  name  = "mysecret"   # Name of the secret
  mount = "secret"     # KV engine mount path

  data_json = jsonencode({
    username = "admin"
    password = "newpassword123"
  })
}
