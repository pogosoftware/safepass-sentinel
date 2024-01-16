output "hcp_boundary_cluster_id" {
  description = "The ID of HCP Boudary cluster"
  value       = join("", regex("https://([a-f0-9-]+)\\.boundary\\.hashicorp\\.cloud", hcp_boundary_cluster.this.cluster_url))
}

output "hcp_boundary_cluster_url" {
  description = "The URL to HCP Boudary"
  value       = hcp_boundary_cluster.this.cluster_url
}