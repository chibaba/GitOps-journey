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
  description = "Environment to be installed"
  type        = string
}

variable "type" {
    description = "Type INGRESS or EGRESS"
    type = string
    default = "INGRESS"
  
}

variable "from_port" {
    description = "allowing traffic to port"
    type =  number
}

variable "to_port" {
  description = "Allowing Traffic To Port"
  type        = number
}

variable "protocol" {
    description = "Protocol TCP/ICMP/UDP"
    type = string
    default = "TCP"
}

variable "cidr_blocks" {
  description = "CIDR Blocks to allow traffic to in case of egress/from in case of ingress"
  type        = list(string)
}