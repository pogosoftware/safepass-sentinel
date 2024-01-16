output "boundary_id" {
  description = "The ID of HCP Boudary"
  value       = hcp_boundary_cluster.this.id
}

output "boundary_cluster_url" {
  description = "The URL to HCP Boudary"
  value       = hcp_boundary_cluster.this.cluster_url
}