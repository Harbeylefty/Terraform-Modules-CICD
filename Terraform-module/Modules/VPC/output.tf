output "vpc_id" {
  value = aws_vpc.myvpc.id 
}

output "public_subnet_id" {
  description = "The id for the public subnets "
  value = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "private_subnet_id" {
  description = "The ID for the private subnet"
  value = aws_subnet.private_subnet.id 
}