# EC2 Instance Outputs
output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.app.public_dns
}

output "application_url" {
  description = "URL to access the application"
  value       = "http://${aws_instance.app.public_ip}:3000"
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = var.ssh_key_name != "" ? "ssh -i ${var.ssh_key_name}.pem ubuntu@${aws_instance.app.public_ip}" : "SSH key not configured"
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.app.id
}
