module "vpc" {
  source              = "./Modules/VPC"
  vpc_cidr            = "10.0.0.0/16"
  public_subnets_cidr = var.public_subnets_cidr
  availability_zones  = ["us-east-1a", "us-east-1b"]
  public_subnet_names = ["public_subnet_1", "public_subnets_2"]
  private_cidr        = var.private_cidr
  availability_zone   = "us-east-1c"
}

module "sg" {
  source  = "./Modules/Security_Group"
  sg_name = "Terraform_SG"
  vpc_id  = module.vpc.vpc_id
}

module "EC2" {
  source            = "./Modules/EC2"
  ami_id            = var.ami_id
  instance_type     = "t2.micro"
  instance_names    = ["instance_1", "instance_2"]
  security_group_id = module.sg.sg_id
  key_name          = var.keyname
  subnet_id         = module.vpc.public_subnet_id
}

module "ALB" {
  source            = "./Modules/ALB"
  alb_name          = "application-load-balancer"
  security_group_id = module.sg.sg_id
  subnet_ids        = module.vpc.public_subnet_id
  target_group_name = "target-group"
  vpc_id            = module.vpc.vpc_id
  instance_ids      = module.EC2.instance_IDs
}