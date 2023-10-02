output "bucket_name" {
  description = "Bucket Name for our static website"
  value = module.terrahouse_aws.bucket_name
}

output "s3_static_endpoint" {
  description = "S3 static website hosting endpoint from bucket-website resource"
  value = module.terrahouse_aws.website_endpoint
}
