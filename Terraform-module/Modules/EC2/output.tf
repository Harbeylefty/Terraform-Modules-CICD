// Output the public IP addresses of EC2 instances
output "instance_public_ips" {
  description = "The public IP address of the EC2 instances."
  value = [for instance in aws_instance.web : instance.public_ip]
}


// output keypair name 
output "key_pair" {
  value = [aws_key_pair.keypair.key_name] 
}

output "instance_IDs" {
  description = "The IDs of each instance"
  value = [for instance in aws_instance.web : instance.id]
}