output "vpc_id" {
  description = "The ID of VPC"
  value       = module.vpc.vpc_id
}

output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  value       = module.vpc.vpc_owner_id
}

output "vpc_cidr_block" {
  description = "The CIDR of VPC"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnet_ids" {
  description = "The ID's of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnet_ids" {
  description = "The ID's of public subnets"
  value       = module.vpc.public_subnets
}

output "security_group_ids" {
  description = "The IDs of security groups"
  value       = { for sg_name, sg in aws_security_group.this : sg_name => sg.id }
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = module.vpc.private_route_table_ids
}
