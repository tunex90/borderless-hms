variable "project_name" { type = string }
variable "environment" { type = string }
variable "aws_region" { type = string }
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "backend_security_group_id" { type = string }
variable "frontend_security_group_id" { type = string }
variable "backend_ecr_url" { type = string }
variable "frontend_ecr_url" { type = string }
variable "backend_target_group_arn" { type = string }
variable "frontend_target_group_arn" { type = string }
variable "postgres_host" { type = string }
variable "postgres_password" {
  type      = string
  sensitive = true
}
variable "jwt_secret_key" {
  type      = string
  sensitive = true
}
variable "backend_min_tasks" { type = number }
variable "backend_max_tasks" { type = number }
variable "frontend_min_tasks" { type = number }
variable "frontend_max_tasks" { type = number }
variable "alb_dns_name" {
  type    = string
  default = ""
}
