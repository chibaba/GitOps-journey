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
}