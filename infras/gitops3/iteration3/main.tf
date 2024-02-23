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
}