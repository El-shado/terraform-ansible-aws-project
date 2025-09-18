module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"

  tags = {
    project = "terraform-ansible-aws"
    env     = "dev"
    owner   = "El-shado"
    cost    = "free-tier"
  }
}

module "security" {
  source = "../../modules/security"

  vpc_id           = module.vpc.vpc_id
  ssh_ingress_cidr = var.ssh_ingress_cidr

  tags = {
    project = "terraform-ansible-aws"
    env     = "dev"
    owner   = "El-shado"
    cost    = "free-tier"
  }
}

module "compute" {
  source = "../../modules/compute"

  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security.security_group_id

  instance_type = "t3.micro"

  key_name = "shadi-rsa"

  volume_size_gb = 8

  tags = {
    project = "terraform-ansible-aws"
    env     = "dev"
    owner   = "El-shado"
    cost    = "free-tier"
  }
}