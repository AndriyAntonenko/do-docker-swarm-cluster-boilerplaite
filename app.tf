module "do_swarm_cluster" {
  source = "./cluster"

  ssh_key   = var.ssh_key
  do_token  = var.do_token
  pvt_key   = var.pvt_key
  do_region = var.do_region
}
