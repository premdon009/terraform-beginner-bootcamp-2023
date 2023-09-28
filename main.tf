terraform {
   cloud {
    organization = "premdon009"

    workspaces {
      name = "terra-house-premdon009"
    }
  }
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.18.1"
    }
  }
}

provider "aws" {
}

provider "random" {
  # Configuration options
}


resource "random_string" "bucket_name" {
length           = 60
special          = true
override_special = "-"
upper = false

}


resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result

  # tags = {
  #   Name        = "My bucket"
  #   Environment = "Dev"
  # }
}



output "random_bucket_name" {
  value = random_string.bucket_name.id
}

