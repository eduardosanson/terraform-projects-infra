provider "aws" {
  profile = "personal-account"
  region = "us-east-1"
}

module "vpc" {
  source = "github.com/eduardosanson/terraform-template-modules//modules/vpc?ref=master"
  cidr_vpc = var.cidr_vpc
  environment_tag = var.environment_tag
}

module "sg" {
  source = "github.com/eduardosanson/terraform-template-modules//modules/sg?ref=master"
  vpc_id = module.vpc.vpc_id
  environment_tag = var.environment_tag
  cidr_subnets = var.cidr_subnets
}

module "defaults-sg" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
  environment_tag = var.environment_tag
}

module "subnets" {
  source = "github.com/eduardosanson/terraform-template-modules//modules/subnets?ref=master"
  vpc_id = module.vpc.vpc_id
  igw_id = module.vpc.ig_id
  subnets_prefix = var.subnets_prefix
  azs = var.subnets_zones
  public_cidrs = var.cidr_subnets
  region = var.region
  private_cidrs = var.cidr_private_subnets
  environment_tag = var.environment_tag
  enable_nat = true
}


