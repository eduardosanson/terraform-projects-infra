variable "cluster_name"                {type = string}
variable "instance_type"               {type = string}
variable "image_id"                    {type = string}
variable "user_data_path"              {type = string}
variable "additional_user_data_script" {type = string}
variable "log_group"                   {type = string}
variable "cluster_max_size"            {type = number}
variable "cluster_min_size"            {type = number}
