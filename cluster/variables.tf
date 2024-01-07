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

variable "env" {
  type        = string
  default     = "dev"
  description = "Environment name. It also will be used as a tag for droplets and part of their names."
}

variable "slaves_count" {
  type        = number
  default     = 2
  description = "Number of slave nodes in the cluster"
}

variable "master_size" {
  type        = string
  default     = "s-1vcpu-1gb"
  description = "Size of the master node"
}

variable "slave_size" {
  type        = string
  default     = "s-1vcpu-1gb"
  description = "Size of the slave nodes"
}

variable "image" {
  type        = string
  default     = "ubuntu-20-04-x64"
  description = "Image that will be used for droplets"
}
