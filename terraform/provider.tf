provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "255229101253-terraform-state"
    key    = "state"
    region = "eu-west-1"
  }
}