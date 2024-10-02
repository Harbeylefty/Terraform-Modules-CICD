variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string 
}

variable "instance_names" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "key_name" {
  type = string 
}

variable "subnet_id" {
  description = "list of subnet IDs where the instances will be deployed"
  type = list(string) 
}