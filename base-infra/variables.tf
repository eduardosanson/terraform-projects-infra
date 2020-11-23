variable "cidr_vpc"             { type = string }
variable "cidr_subnets"         { type = list(string) }
variable "environment_tag"      { type = string }
variable "subnets_zones"        { type = list(string) }
variable "region"               { type = string }
variable "subnets_prefix"       { type = string}
variable "cidr_private_subnets" { type = list(string) }
