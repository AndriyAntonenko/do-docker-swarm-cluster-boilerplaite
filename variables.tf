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

variable "master_size" {
  type        = string
  default     = "s-1vcpu-2gb"
  description = "Size of the master node"
}

variable "slave_size" {
  type        = string
  default     = "s-1vcpu-2gb"
  description = "Size of the worker nodes"
}
