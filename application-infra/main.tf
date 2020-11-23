provider "aws" {
  profile = "personal-account"
  region = "us-east-1"
}


data "terraform_remote_state" "vpc" {
  backend = "s3"

  workspace = terraform.workspace

  config = {
    bucket = "prod-infra-init-terraform.state"
    region = "us-east-1"
    key    = "infra-application/terraform.tfstate"
    profile = "personal-account"
  }
}

module "lb" {
  source = "github.com/eduardosanson/terraform-template-modules//modules/lb?ref=master"
  sg_id           = data.terraform_remote_state.vpc.outputs.sg-application
  vpc_subnets     = data.terraform_remote_state.vpc.outputs.public_subnet
  lb-name         = var.cluster_name
  lb-type         = "application"
}

module "role" {
  source = "github.com/eduardosanson/terraform-template-modules//modules/ecs-cluster/role?ref=master"
  cluster_name = var.cluster_name
}

module "ecs" {
  source = "github.com/eduardosanson/terraform-template-modules//modules/ecs-cluster/ecs-cluster?ref=master"
  cluster_name = "${var.cluster_name}-${terraform.workspace}"
}

module "sg" {
  source = "./modules/security-group"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  environment_tag = "prod"
  sg_name = var.cluster_name
}

module "instance-configuration" {
  source = "github.com/eduardosanson/terraform-template-modules//modules/ecs-cluster/instances?ref=master"

  instance_profile_arn        = module.role.ecs-instance-profile-arn
  security_group_ids          = [module.sg.id, data.terraform_remote_state.vpc.outputs.sg-application, data.terraform_remote_state.vpc.outputs.sg-ecs]
  aws_subnet_ids              = data.terraform_remote_state.vpc.outputs.private_subnet
  vpc_id                      = data.terraform_remote_state.vpc.outputs.vpc_id
  ecs_cluster                 = "${var.cluster_name}-${terraform.workspace}"
  cluster_max_size            = var.cluster_max_size
  cluster_min_size            = var.cluster_min_size
  cluster_name                = var.cluster_name
  image_id                    = var.image_id
  instance_type               = var.instance_type
  name                        = var.cluster_name
  user_data_path              = var.user_data_path
  additional_user_data_script = var.additional_user_data_script
  log_group                   = var.log_group
}

module "auto-scalling" {
  source = "github.com/eduardosanson/terraform-template-modules//modules/ecs-cluster/auto-scalling?ref=master"
  launch_configuration_id = module.instance-configuration.launch_configuration_id
  subnet_ids       = data.terraform_remote_state.vpc.outputs.public_subnet
  cluster_name     = var.cluster_name
  cluster_max_size = var.cluster_max_size
  cluster_min_size = var.cluster_min_size
}

module "redis" {
  source = "./modules/redis"
  subnets = data.terraform_remote_state.vpc.outputs.private_subnet
  cluster_id = var.cluster_name
  namespace = "${var.cluster_name}-cache"
  node_groups = 2
  sgs = [data.terraform_remote_state.vpc.outputs.sg-db]
}