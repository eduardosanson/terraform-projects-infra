output "redis-endpoint-address" {
  value = aws_elasticache_replication_group.default.configuration_endpoint_address
}