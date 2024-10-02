variable "alb_name" {
  description = "Name of the Application load balancer"
  type = string 
}

variable "security_group_id" {
  description = "security group for the ALB"
  type = string
}

variable "subnet_ids" {
  description = "Subnets for the ALB"
  type = list(string)
}

variable "target_group_name" {
  type = string
}

variable "vpc_id" {
  type = string 
}

variable "instance_ids" {
  description = "List of instance id to attach to the target group"
  type = list(string)
}