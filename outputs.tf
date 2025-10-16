output "instance_ids" {
  description = "The IDs of the created EC2 instances."
  value       = aws_instance.ec2_instance[*].id
}

output "instance_public_ips" {
  description = "The public IP addresses of the EC2 instances."
  value       = aws_instance.ec2_instance[*].public_ip
}

output "instance_private_ips" {
  description = "The private IP addresses of the EC2 instances."
  value       = aws_instance.ec2_instance[*].private_ip
}

output "instance_arns" {
  description = "The ARNs of the EC2 instances."
  value       = aws_instance.ec2_instance[*].arn
}
