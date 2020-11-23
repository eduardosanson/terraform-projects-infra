variable "namespace"   {type = string}
variable "subnets"     {type = list(string)}
variable "node_groups" {type = number}
variable "cluster_id"  {type = string}
variable "sgs"         {type = list(string)}