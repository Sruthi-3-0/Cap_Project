output "container_id" {
  description = "Docker container ID"
  value       = docker_container.nginx_container.id
}

output "container_name" {
  description = "Docker container name"
  value       = docker_container.nginx_container.name
}

output "vault_secret_username" {
  description = "Username stored in Vault secret"
  value       = vault_kv_secret_v2.mysecret.data["username"]
}

output "vault_secret_password" {
  description = "Password stored in Vault secret"
  value       = vault_kv_secret_v2.mysecret.data["password"]
}
