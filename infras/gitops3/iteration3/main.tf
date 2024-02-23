locals {
    name-suffix = "${var.region}-${var.environment}"
}

# fetching the ami id of ubuntu 20.04

data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

      owners = ["099720109477"]

}

# HTTP ingress security module
module "http_sg_ingress" {
    source = "./modules/security_group"
    sg_name = "http_sg_ingress"
    sg_desription = "allow Port 80 from anywhere"
    environment = var.environment
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

# Generic egress security group module
module "generic_sg_egress" {
    source = "./modules/security_group"
    sg_name = "generic_sg_egress"
    sg_desription = "allow server to connect to the outbound internet"
    environment = var.environment
    type = "egress"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}