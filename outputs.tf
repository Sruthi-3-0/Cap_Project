output "container_name" {
  value = docker_container.nginx_container.name
}

output "container_ip" {
  value = docker_container.nginx_container.ip_address
}
