resource "digitalocean_droplet" "slave" {
  depends_on = [digitalocean_droplet.master]
  count      = var.slaves_count
  image      = var.image
  region     = var.do_region
  size       = var.slave_size
  name       = format("slave-%s-%s", var.env, count.index)

  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    timeout     = "2m"
    private_key = file(var.pvt_key)
  }

  provisioner "file" {
    source      = var.pvt_key
    destination = "/root/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    on_failure = fail
    when       = create

    inline = [
      "export PATH=$PATH:/usr/bin",
      # Install Docker
      "sudo apt-get update",
      "echo \"Updated packages\"",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "echo \"Installed apt-transport-https ca-certificates curl and software-properties-common\"",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "echo \"Downloaded docker gpg key\"",
      "echo \"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "echo \"Added docker repo to apt sources\"",
      "sudo apt-get update",
      "echo \"Updated packages\"",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
      "echo \"Installed docker-ce docker-ce-cli containerd.io\"",

      # Add your user to the docker group to run Docker without sudo
      "sudo usermod -aG docker $USER",

      # Start Docker on boot
      "sudo systemctl enable docker",

      # Verify Docker installation
      "docker --version",

      "sudo chmod 400 /root/.ssh/id_rsa",
      "sudo scp -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null root@${digitalocean_droplet.master.ipv4_address_private}:/swarm-token /swarm-token",
      "sudo docker swarm join --token $(cat /swarm-token) ${digitalocean_droplet.master.ipv4_address_private}:2377"
    ]
  }

  tags = ["swarm", "slave", var.env, format("%s-cluster-node", var.env)]
}
