resource "digitalocean_firewall" "default_cluster_node_firewall" {
  depends_on = [digitalocean_droplet.master, digitalocean_droplet.slave]

  name = format("%s-cluster-firewall", var.env)
  tags = [format("%s-cluster-node", var.env)]

  # Allow inbound HTTP and HTTPS from anywhere
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Allow outbound HTTP and HTTPS from anywhere
  outbound_rule {
    protocol              = "tcp"
    port_range            = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Allow outbound DNS from anywhere
  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Allow inbound SSH from anywhere
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Enable docker swarm communication
  inbound_rule {
    protocol    = "tcp"
    port_range  = "2377"
    source_tags = [format("%s-cluster-node", var.env)]
  }

  inbound_rule {
    protocol    = "tcp"
    port_range  = "2376"
    source_tags = [format("%s-cluster-node", var.env)]
  }

  inbound_rule {
    protocol    = "tcp"
    port_range  = "7946"
    source_tags = [format("%s-cluster-node", var.env)]
  }

  inbound_rule {
    protocol    = "udp"
    port_range  = "7946"
    source_tags = [format("%s-cluster-node", var.env)]
  }

  inbound_rule {
    protocol    = "udp"
    port_range  = "4789"
    source_tags = [format("%s-cluster-node", var.env)]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "2377"
    destination_tags = [format("%s-cluster-node", var.env)]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "2376"
    destination_tags = [format("%s-cluster-node", var.env)]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "7946"
    destination_tags = [format("%s-cluster-node", var.env)]
  }

  outbound_rule {
    protocol         = "udp"
    port_range       = "7946"
    destination_tags = [format("%s-cluster-node", var.env)]
  }

  outbound_rule {
    protocol         = "udp"
    port_range       = "4789"
    destination_tags = [format("%s-cluster-node", var.env)]
  }
}
