variable "container_name" {
  type    = string
  default = "nginx_demo"
}

variable "external_port" {
  type    = number
  default = 8081
}

variable "vault_token" {
  type    = string
  description = "Vault token is read from environment variable"
  default = ""  # will use ENV variable, not hardcoded
}
