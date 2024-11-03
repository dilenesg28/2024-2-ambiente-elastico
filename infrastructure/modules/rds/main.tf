#main.tf
# Definindo o provider AWS
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  #token      = var.session_token
}

# Criando um Security Group para a instância de banco de dados RDS
resource "aws_security_group" "rds_sg" {
  name = "rds_sg"

  ingress {
    from_port   = 5432                        # Porta padrão do PostgreSQL
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]               # Ajuste conforme necessário para limitar o acesso
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Criando uma instância de banco de dados RDS
resource "aws_db_instance" "myinstance" {
  engine               = "postgres"
  identifier           = "myrdsinstance"
  allocated_storage    = 20
  engine_version       = "13.3"                    # Atualize para a versão do PostgreSQL desejada
  instance_class       = "db.t3.micro"
  username             = "usradmin"
  password             = "S3nhaSup34S3gura"
  parameter_group_name = "default.postgres13"      # Ajuste para o grupo de parâmetros do PostgreSQL
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true
  publicly_accessible  = false                     # Defina como false para mantê-lo na rede privada
}
