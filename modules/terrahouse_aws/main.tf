terraform {
  required_providers {
   aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

# reference link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags = {
    UserUuid  = var.user_uuid
    project = "terraform-beginner-bootcamp-2023"
  }
}

# reference link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# reference Link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  # source = "/workspace/terraform-beginner-bootcamp-2023/public/index.html"
  # source = "${path.root}/public/index.html"
  source = var.index_html_filepath

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  ## Reference Link: https://developer.hashicorp.com/terraform/language/functions/filemd5
  etag = filemd5(var.index_html_filepath)
}
# reference Link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  # source = "/workspace/terraform-beginner-bootcamp-2023/public/index.html"
  # source = "${path.root}/public/error.html"
  source = var.error_html_filepath

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  ## Reference Link: https://developer.hashicorp.com/terraform/language/functions/filemd5
  etag = filemd5(var.error_html_filepath)
}