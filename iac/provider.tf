terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "#{S3_BUCKET_NAME}#"
    key    = "state"
    region = "#{AWS_REGION}#"
  }
}

provider "aws" {
  region = "#{AWS_REGION}#"
}
