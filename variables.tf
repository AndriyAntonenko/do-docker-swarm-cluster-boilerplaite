variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
}

variable "pvt_key" {
  type        = string
  default     = "~/.ssh/id_rsa"
  description = "Path to private key that will be used to connect to droplets. Its pair for public key should be added to DigitalOcean."
}

variable "do_region" {
  type        = string
  default     = "nyc1"
  description = "DigitalOcean region where droplets will be created."
}

# The name of the SSH key in DigitalOcean
variable "ssh_key" {
  type        = string
  description = "Name of the SSH key in DigitalOcean"
}
