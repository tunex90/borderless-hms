output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "backend_ecr_repository_url" {
  value = module.ecr.backend_repository_url
}

output "frontend_ecr_repository_url" {
  value = module.ecr.frontend_repository_url
}

output "rds_endpoint" {
  value     = module.rds.db_endpoint
  sensitive = true
}
