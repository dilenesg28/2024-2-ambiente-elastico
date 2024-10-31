variable "db_name" {
  type        = string
  description = "Nome do banco de dados"
}

variable "db_username" {
  type        = string
  description = "Nome de usuário do banco de dados"
}

variable "db_password" {
  type        = string
  description = "Senha do banco de dados"
  sensitive   = true
}

variable "security_group_id" {
  type        = string
  description = "ID do Security Group para o banco de dados"
}

variable "db_subnet_group_name" {
  type        = string
  description = "Nome do grupo de subnets para o banco de dados"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Lista de IDs das subnets privadas para o banco de dados"
}
