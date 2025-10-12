provider "docker" {}

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
