terraform {
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

# provider "aws" {
#   # Configuration options
#   region     = AWS_DEFAULT_REGION
#   access_key = AWS_ACCESS_KEY_ID
#   secret_key = AWS_SECRET_ACCESS_KEY
# }

provider "random" {
  # Configuration options
}


resource "random_string" "bucket_name" {
length           = 60
special          = true
override_special = "-"
upper = false

}


# resource "aws_s3_bucket" "example" {
#   bucket = random_string.bucket_name.result

#   # tags = {
#   #   Name        = "My bucket"
#   #   Environment = "Dev"
#   # }
# }



output "random_bucket_name" {
  value = random_string.bucket_name.id
}

