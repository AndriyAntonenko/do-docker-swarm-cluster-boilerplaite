output "master_ip" {
  value = digitalocean_droplet.master.ipv4_address
}

output "master_private_ip" {
  value = digitalocean_droplet.master.ipv4_address_private
}
