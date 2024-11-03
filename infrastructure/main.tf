# versions.tf

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0" # Certifique-se de que a versão é 4.0 ou superior
    }
  }
}


provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key

}


module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  AZ                  = var.AZ
  vpc_name            = "aula-10-VPC"
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"

  alb_name                         = "external-ALB"
  internal                         = false
  security_group_ids               = [module.security_groups.alb_sg_id]
  subnet_ids                       = module.vpc.public_subnet_ids
  target_group_name                = "external-web-group"
  target_group_port                = 80
  target_group_protocol            = "HTTP"
  vpc_id                           = module.vpc.vpc_id
  listener_port                    = 80
  listener_protocol                = "HTTP"
  health_check_path                = "/"
  health_check_protocol            = "HTTP"
  health_check_interval            = 30
  health_check_timeout             = 5
  health_check_healthy_threshold   = 5
  health_check_unhealthy_threshold = 2
  tags = {
    Name = "external-ALB"
  }
}

module "ec2" {
  source = "./modules/ec2"

  ami               = var.ami
  instance_type     = var.instance_type
  public_subnet_ids = module.vpc.public_subnet_ids
  webtier_sg_id     = module.security_groups.webtier_sg_id
  user_data         = var.user_data
  target_group_arn  = module.alb.target_group_arn
  desired_capacity  = 2
  max_size          = 5
  min_size          = 2
  tags = {
    Environment = "Production"
  }
}
#module "rds" {
  #source      = "./modules/rds"
  #region      = var.region       # Certifique-se de que var.region está definido
  #access_key  = var.access_key   # Certifique-se de que var.access_key está definido
  #secret_key  = var.secret_key   # Certifique-se de que var.secret_key está definido
  #engine               = "mysql"
  #identifier           = "myrdsinstance"
  #allocated_storage    =  20
  #engine_version       = "8.0.35"
  #instance_class       = "db.t3.micro"
  #username             = "usradmin"
  #password             = "S3nhaSup34S3gura"
  #parameter_group_name = "default.mysql8.0"
  #vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  #skip_final_snapshot  = true
  #publicly_accessible =  true
  
#}

module "rds" {
  source               = "./modules/rds"
  engine               = "postgres"
  engine_version       = "13.3"
  instance_class       = "db.t3.micro"

  allocated_storage  = 20  # especifique o tamanho do armazenamento em GB
  identifier         = "meu-banco"                  # identificador único para a instância do DB

  region     = var.region # região da AWS
  access_key = var.access_key
  secret_key = var.secret_key


  username             = "usradmin"
  password             = "S3nhaSup34S3gura"
  parameter_group_name = "default.postgres13"
  vpc_security_group_ids = [module.security_groups.webtier_sg_id]
  publicly_accessible  = false
  skip_final_snapshot  = true
}

                         
  