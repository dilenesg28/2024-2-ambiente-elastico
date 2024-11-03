
variable "region" {
  description = "AWS region"
  type        = string
}

variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage size for RDS"
  type        = number
}


variable "engine" {
  description = "Database engine for RDS"
  type        = string
  default     = "postgres"            # Defina como PostgreSQL por padrão
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "13.3"                # Defina uma versão padrão do PostgreSQL
}

variable "instance_class" {
  description = "Class of the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "username" {
  description = "Username for the RDS"
  type        = string
}

variable "password" {
  description = "Password for the RDS"
  type        = string
}

variable "parameter_group_name" {
  description = "Parameter group name for the RDS"
  type        = string
  default     = "default.postgres13"  # Grupo de parâmetros do PostgreSQL
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "Should the RDS be publicly accessible"
  type        = bool
  default     = false                 # Para manter na rede privada por padrão
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot before deletion"
  type        = bool
  default     = true
}

#variable "session_token" {
#  description = "Token de sessão para autenticação na AWS"
#  type        = string
#  default     = ""  # Você pode definir um valor padrão se quiser
#}
