variable "container_name" {
  type    = string
  default = "nginx_demo"
}

variable "external_port" {
  type    = number
  default = 8081
}

variable "vault_token" {
  type        = string
  description = "Vault root token (or set via ENV)"
  default     = ""  # Terraform reads from ENV
}
