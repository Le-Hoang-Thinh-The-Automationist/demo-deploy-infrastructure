module "vpc" {
  source               = "./modules/vpc"
  vpc_name             = var.vpc_name
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  public_subnet_cidr   = var.public_subnet_cidr
  availability_zone    = var.availability_zone
  tags                 = var.tags
}

module "ec2" {
  source        = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_id
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags          = var.tags
}

module "ecr_repo" {
  source           = "./modules/ecr"
  ecr_repo_name    = var.ecr_repo_name
  image_mutability = var.image_mutability
  scan_on_push     = var.scan_on_push
  encryption_type  = var.encryption_type
  tags             = var.tags
}
