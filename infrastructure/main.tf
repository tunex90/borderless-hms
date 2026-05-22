terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "borderless-hms-terraform-state-860639121448"
    key          = "production/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
  environment  = var.environment
}

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
}

module "rds" {
  source              = "./modules/rds"
  project_name        = var.project_name
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  db_security_group_id = module.vpc.rds_security_group_id
  postgres_password   = var.postgres_password
  rds_instance_class  = var.rds_instance_class
  rds_multi_az        = var.rds_multi_az
}

module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_security_group_id = module.vpc.alb_security_group_id
}

module "ecs" {
  source                  = "./modules/ecs"
  project_name            = var.project_name
  environment             = var.environment
  aws_region              = var.aws_region
  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.vpc.private_subnet_ids
  backend_security_group_id  = module.vpc.backend_security_group_id
  frontend_security_group_id = module.vpc.frontend_security_group_id
  backend_ecr_url         = module.ecr.backend_repository_url
  frontend_ecr_url        = module.ecr.frontend_repository_url
  backend_target_group_arn  = module.alb.backend_target_group_arn
  frontend_target_group_arn = module.alb.frontend_target_group_arn
  postgres_host           = module.rds.db_endpoint
  postgres_password       = var.postgres_password
  jwt_secret_key          = var.jwt_secret_key
  backend_min_tasks       = var.backend_min_tasks
  backend_max_tasks       = var.backend_max_tasks
  frontend_min_tasks      = var.frontend_min_tasks
  frontend_max_tasks      = var.frontend_max_tasks
}
