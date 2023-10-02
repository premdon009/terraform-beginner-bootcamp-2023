output "bucket_name" {
  value = aws_s3_bucket.website_bucket.bucket
}

## You cant use it since The attribute "website_endpoint" is deprecated.
# output "website_endpoint1" {

#   description = "value of bucket endpoint from bucket resource"
#   value = aws_s3_bucket.website_bucket.website_endpoint
# }

output "website_endpoint" {
  description = "value of bucket endpoint from bucket website resource"
  value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}
