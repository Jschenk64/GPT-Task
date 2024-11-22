# outputs.tf
output "aws_region" {
  description = "The AWS region where resources are deployed"
  value       = var.region
}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.grippo_vpc.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = [aws_subnet.grippo_public_subnet_1.id, aws_subnet.grippo_public_subnet_2.id]
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = [aws_subnet.grippo_private_subnet_1.id, aws_subnet.grippo_private_subnet_2.id]
}

output "nat_gateway_ip" {
  description = "Elastic IP of the NAT Gateway"
  value       = aws_eip.grippo_eip.public_ip
}

output "web_instance_ips" {
  description = "Public IPs of web instances"
  value       = [aws_instance.web_instance_1.public_ip, aws_instance.web_instance_2.public_ip]
}

output "rds_instance_private_ips" {
  description = "Private IPs of RDS instances"
  value       = [aws_instance.rds_instance_1.private_ip, aws_instance.rds_instance_2.private_ip]
}

output "web_instance_key_names" {
  description = "Key names used for web instances"
  value       = [
    aws_instance.web_instance_1.key_name,
    aws_instance.web_instance_2.key_name,
    aws_instance.rds_instance_1.key_name,
    aws_instance.rds_instance_2.key_name
  ]
}


