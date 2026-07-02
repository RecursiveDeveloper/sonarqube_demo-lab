module "Vpc_module" {
  source = "./modules/vpc"
}

module "Ec2_module" {
  source = "./modules/ec2"

  sonarqube_instance_ami      = var.sonarqube_instance_ami
  sonarqube_instance_type     = var.sonarqube_instance_type
  sonarqube_public_subnet_id  = module.Vpc_module.sonarqube_public_subnet_id
  sonarqube_vpc_id            = module.Vpc_module.sonarqube_vpc_id
}