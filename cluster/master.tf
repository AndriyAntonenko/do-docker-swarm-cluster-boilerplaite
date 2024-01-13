resource "digitalocean_droplet" "master" {
  depends_on = [data.digitalocean_ssh_key.terraform]
  image      = "ubuntu-20-04-x64"
  name       = format("master-%s", var.env)
  region     = var.do_region
  size       = var.master_size

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

      # Init swarm
      "sudo docker swarm init --advertise-addr ${self.ipv4_address}",
      "sudo docker swarm join-token --quiet worker > /swarm-token",
    ]
  }

  tags = ["swarm", "master", var.env, format("%s-cluster-node", var.env)]
}
