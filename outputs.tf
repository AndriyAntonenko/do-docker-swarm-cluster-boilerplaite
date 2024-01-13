output "master_node_ip" {
  value       = module.do_swarm_cluster.master_ip
  description = "IP address of the master node, could be used to connect to the cluster"
}
