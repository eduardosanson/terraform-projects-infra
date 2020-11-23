output "lb_arn" {
  value = module.lb.lb_arn
}

output "lb_dns" {
  value = module.lb.lb_dns
}

output "instance_profile_arn" {
  value = module.role.ecs-instance-profile-arn
}

output "instance_profile_role_name" {
  value = module.role.ecs-instance-profiel-role-name
}

output "redis_address" {
  value = module.redis.redis-endpoint-address
}
