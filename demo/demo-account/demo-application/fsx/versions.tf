data "aws_partition" "this" {}
data "aws_caller_identity" "this" {}
data "aws_region" "this" {}
provider "aws" {
  region = "ap-southeast-1"
  assume_role {
    role_arn = "arn:aws:iam::129980683758:role/AdminRole"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.5.0"

  backend "s3" {
    key            = "demo/demo-account/demo-application/fsx.tfstate"
    bucket         = "maersk-remote-tfstate-poc"
    dynamodb_table = "maersk-remote-state-lock"
    region         = "ap-southeast-1"
  }

}