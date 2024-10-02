// create Keypair for instance 
terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.6"
    }
  }
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "keypair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "keypair" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "${var.key_name}.pem"
}


// create Instances 
resource "aws_instance" "web" {
  count = length(var.instance_names)
  ami = var.ami_id
  instance_type = var.instance_type 
  subnet_id = var.subnet_id[count.index]
  key_name = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true 
  user_data = file("${path.module}/instance${count.index + 1}.sh")

  tags = {
    Name = var.instance_names[count.index]
  }
}



