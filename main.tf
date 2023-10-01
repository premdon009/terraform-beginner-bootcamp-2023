terraform {
  #  cloud {
  #   organization = "premdon009"

  #   workspaces {
  #     name = "terra-house-premdon009"
  #   }
  # }
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}