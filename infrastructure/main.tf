
module "two-tier-arch" {
  source = "./modules"


  region              = var.region
  vpc_cidr            = var.vpc_cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr


  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

}

