variable "public_subnets_cidr" {
  type = list(string)
}

variable "private_cidr" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "keyname" {
  type = string
}