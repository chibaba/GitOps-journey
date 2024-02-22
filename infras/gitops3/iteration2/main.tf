variable "environment" {
  description = "The environment e.g uat or prod or dev"
  type        = string
}

variable "region" {
  description = "The region where we wish to deploy to"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

locals {
  name-suffix = "${var.region}-${var.environment}"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.10"
    }
  }

  required_version = ">= 1.1.0"
}