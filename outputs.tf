output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.nginx_container.id
}

output "container_name" {
  description = "Name of the Docker container"
  value       = docker_container.nginx_container.name
}

output "container_ip" {
  description = "IP address of the Docker container"
  value       = docker_container.nginx_container.network_data[0].ip_address
}

output "vault_secret_username" {
  description = "Username stored in Vault secret"
  value       = vault_kv_secret_v2.mysecret.data["username"]
}

output "vault_secret_password" {
  description = "Password stored in Vault secret"
  value       = vault_kv_secret_v2.mysecret.data["password"]
}
