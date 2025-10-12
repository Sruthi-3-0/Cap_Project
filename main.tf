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

variable "vault_addr" {
  type        = string
  description = "Vault server address"
}

variable "vault_token" {
  type        = string
  description = "Vault authentication token"
  sensitive   = true
}

provider "vault" {
  address = var.vault_addr
  token   = var.vault_token
}

data "vault_generic_secret" "mysecret" {
  path = "secret/mysecret"
}

variable "container_name" {
  type        = string
  default     = "nginx_demo"
  description = "Docker container name"
}

variable "external_port" {
  type        = number
  default     = 8080
  description = "External port to expose"
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

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

output "container_info" {
  value = {
    container_name = docker_container.nginx_container.name
    external_port  = var.external_port
  }
}
