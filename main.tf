# Variables
variable "aws_profile" {
  description = "AWSCLI profile to use for provisioning"
}

variable "aws_region" {
  description = "AWS region to provision into"
  default     = "us-west-2"
}

variable "bucket_name" {
  description = "Name of the S3 bucket to create for the Terraform backend store"
}

variable "table_name" {
  description = "Name of the DynamoDB table to create for backend state locking"
}

variable "tag_owner" {
  description = "Name of the owner of the bucket and table"
}

variable "tag_environment" {
  description = "Name of the environment the backend is used for"
}


# AWS Provider
provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.aws_region}"
}


# Terraform S3 Backend
module "terraform-s3-backend" {
  source = "github.com/bradyjas/jborg-terraform-modules//terraform-s3-backend"

  bucket_name = "${var.bucket_name}"
  table_name  = "${var.table_name}"

  tags = {
    Owner       = "${var.tag_owner}"
    Environment = "${var.tag_environment}"
    CreatedBy   = "Terraform"
  }
}
