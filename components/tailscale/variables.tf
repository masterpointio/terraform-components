variable "tailscale_existing_ssh_key_name" {
  type        = string
  description = "Use an existing EC2 key pair with this name, rather than importing a key pair."
  default     = null
}

variable "tailscale_session_logging_enabled" {
  type        = bool
  description = "Tailscale Subnet Router session logging to S3."
  default     = true
}

variable "ssh_public_key_file" {
  type        = string
  description = "Name of existing SSH public key file (e.g. `id_rsa.pub`)"
  default     = null
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to SSH public key directory (e.g. `/secrets`)"
}