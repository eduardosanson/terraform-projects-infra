output "sg_application_id" {
  value = aws_security_group.sg-application.id
}

output "sg_db_id" {
  value = aws_security_group.sg-db-internal.id
}

output "sg_ecs" {
  value = aws_security_group.sg-ecs.id
}