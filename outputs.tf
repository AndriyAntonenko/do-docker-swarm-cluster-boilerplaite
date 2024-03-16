output "master_node_ip" {
  value       = module.do_swarm_cluster.master_ip
  description = "IP address of the master node, could be used to connect to the cluster"
}

output "master_node_private_ip" {
  value       = module.do_swarm_cluster.master_private_ip
  description = "Private IP address of the master node, could be used to connect to the cluster from private vpc"

}
