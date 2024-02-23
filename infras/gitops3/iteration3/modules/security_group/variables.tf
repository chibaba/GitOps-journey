variable "sg_name" {
    description = "The name of the security group"
    type = string  
}

variable "sg_desription" {
    description = "The description of the security group"
    type = string
    default = ""
}

variable "environment" {
    description = "environment is to be installed"
    type = string
}

variable "type" {
    description = "Type INGRESS or EGRESS"
    type = string
    default = "INGRESS"
  
}

variable "from-port" {
    
}