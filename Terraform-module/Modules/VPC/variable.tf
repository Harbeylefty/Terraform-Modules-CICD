variable "vpc_cidr" {
  description = "Cidr_block for VPC"
  type = string 
}

variable "public_subnets_cidr" {
  description = "cidr_range for the public subnets"
  type = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for the public subnets"
  type = list(string)
}

variable "public_subnet_names" {
  description = "Names for public subnets"
  type = list(string)
}

variable "private_cidr" {
  description = "cidr_block for private subnet"
  type = string 
}

variable "availability_zone" {
  description = "availability zone for private subnet"
  type = string 
}
