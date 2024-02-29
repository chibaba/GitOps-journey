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

# ssh ingress security group module
module "ssh_sg_ingress" {
    source = "./modules/security_group"
    sg_name = "ssh_sg_ingress"
    sg_desription = "Allow port 22 from anywhere"
    environment = var.environment
    type = ingress
    from_port = 22
    to_port = 22
    protocol = tcp
    cidr_blocks = ["0.0.0.0/0"]
}

# AWS EC2 Resource creation

resource "aws_instance" "apache2_server" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    vpc_security_group_ids = [module.http_sg_ingress.sg_id,
     module.generic_sg_egress.sg_id,module.ssh_sg_ingress.sg_id]
    key_name = var.ssh_key_name
    user_data = file("scripts/user_data.sh") 
    tags = {
        env = var.environment
        name = "ec2-${local.name-suffix}"
    }
    depends_on = [ 
        module.generic_sg_egress
     ]
  
}