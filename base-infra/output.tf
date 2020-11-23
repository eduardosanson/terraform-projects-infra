output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet" {
  value = module.subnets.public_subnet
}

output "public_route_table" {
  value = module.subnets.public_route_table
}

output "private_subnet" {
  value = module.subnets.private_subnet
}

output "private_route_table" {
  value = module.subnets.private_route_table
}

output "sg" {
  value = module.sg.sg_id
}

output "nat_gateway" {
  value = module.subnets.nat_gateway_id
}

output "sg-application" {
  value = module.defaults-sg.sg_application_id
}

output "sg-db" {
  value = module.defaults-sg.sg_db_id
}

output "sg-ecs" {
  value = module.defaults-sg.sg_ecs
}


