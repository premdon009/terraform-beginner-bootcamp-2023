# Terraform Beginner Bootcamp 2023 - Week 1

:arrow_backward: [README.md](../README.md) 

## Table Of Content (TOC) - Week 1

- **[Root Module Structure](#root-module-structure)**
- **[Terrform Input Variables](#terrform-input-variables)**
  - **[Terrform Cloud Variables](#terrform-cloud-variables)**
  - **[Loading Terraform Input Variables](#loading-terraform-input-variables)**
  - **[`-var` Flag](#--var--flag)**
  - **[var-file flag](#var-file-flag)**
  - **[teraform.tfvars](#teraformtfvars)**
  - **[auto.tfvars](#autotfvars)**
  - **[Order of Terrform variables](#order-of-terrform-variables)**
- **[Dealing with Configuration Drift](#dealing-with-configuration-drift)**
  - **[What happens if we lose state file in terraform.](#what-happens-if-we-lose-state-file-in-terraform)**
  - **[Fix Missing Resources with Terraform Import](#fix-missing-resources-with-terraform-import)**
  - **[Fix Manual Configuration](#fix-manual-configuration)**
- **[Terraform Module](#terraform-module)**
  - **[Terrforma Module Structure](#terrforma-module-structure)**
  - **[Passing Input Variables](#passing-input-variables)**
  - **[Module Sources](#module-sources)**
  - **[Important info regarding Variables, Output & Providers in modules.](#important-info-regarding-variables-output--providers-in-modules)**
  - **[Consideration when using ChatGPT to write terraform](#consideration-when-using-chatgpt-to-write-terraform)**
  - **[Working with files in Terraform](#working-with-files-in-terraform)**
    - **[Path Variable](#path-variable)**
  - **[Terraform Data Sources](#terraform-data-sources)**
  - **[Terraform Locals](#terraform-locals)**
  - **[Working with JSON](#working-with-json)**
- **[AWS CloudFront Intergration.](#aws-cloudfront-intergration)**
  - **[Origin Access Control (OAC)](#origin-access-control-oac)**


## Root Module Structure

The terraform file structure followed as per Terraform Docuements are given below:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

For more details, please visit  [Terraform File Structure Documentation](https://developer.hashicorp.com/terraform/language/modules/develop/structure)


## Terrform Input Variables
### Terrform Cloud Variables

In terraform, we can set 2 kind of variables:

 - Enviroment Variable  - These are varibles that are been set in the bash terminal.
 - Terraform Variable   - These are variable that are set in `.tfvars` 

 We can also set variables to sensitive which will not be shown after been set.

### Loading Terraform Input Variables

For more information, visit [Terraform Input Varibles](https://developer.hashicorp.com/terraform/language/values/variables)

### `-var` Flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file. eg: `terraform -var user_uuid="my-user-id"`

### var-file flag

 - TODO: document this flag

### teraform.tfvars

This is the default file to load in terraform for variables.

### auto.tfvars

- TODO: document this functionality for terrform cloud

### Order of Terrform variables

- TODO: document which terraform variables takes precedence


## Dealing with Configuration Drift

### What happens if we lose state file in terraform.

If you lose the state file, then you have destroy all your projects cloud infrastructure manually.

You can use terraform import for importing the current state. But it will not work for all cloud providers.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

For more information, please visit [Terraform Import Documentation](https://developer.hashicorp.com/terraform/cli/import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps.

If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift

## Terraform Module 

### Terrforma Module Structure

It is recommeded to place modules in `modules` folder when developing modules locally but you can name it whatever you like.


### Passing Input Variables

We can pass input variables to our module. The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Module Sources 

Module Sources documents what kinds of paths, addresses, and URIs can be used in the source argument of a module block.

The module installer supports installation from a number of different source types.

- Local paths
- Terraform Registry
- GitHub
- Bitbucket
- Generic Git, Mercurial repositories
- HTTP URLs
- S3 buckets
- GCS buckets
- Modules in Package Sub-directories

For more information, please visit [Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

### Important info regarding Variables, Output & Providers in modules.

1. It is to be noted that the modules should be imported in the `main.tf` at `PROJECT_ROOT` folder with variables to linked in modules.

    ```tf
    # example code

    # in main.tf in PROJECT_ROOT

    module "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
    user_uuid = var.user_uuid
    bucket_name = var.bucket_name
    }

    # in main.tf in module terrahouse_aws

    resource "aws_s3_bucket" "website_bucket" {
    bucket = var.bucket_name

    tags = {
      UserUuid  = var.user_uuid
      project = "terraform-beginner-bootcamp-2023"
      }
    }
    ```

1. Variable used in the modules should be mentioned in the variables file (`variable.tf`) at `PROJECT_ROOT` and can contain a type or desc which can viewed for reference.
    ```tf
    # in variable.tf in PROJECT_ROOT
    variable "user_uuid" {
      type = string
    }

    variable "bucket_name" {
      type = string
    }

    # in variable.tf in module terrahouse_aws
    variable "user_uuid" {
      description = "The UUID of the user"
      type        = string
    }

    variable "bucket_name" {
      description = "The name of the S3 bucket"
      type        = string
    }
    ```
1. If the output for a module should be shown in the terminal or in the `PROJECT_ROOT` from the modules, the same should be imported in the `output.tf` at `PROJECT_ROOT`.
    ```tf
    # in output.tf in PROJECT_ROOT
    output "bucket_name" {
      description = "Bucket Name for our static website"
      value = module.terrahouse_aws.bucket_name
    }

    # in output.tf in module terrahouse_aws
    output "bucket_name" {
      value = aws_s3_bucket.website_bucket.bucket # referrenced from provider mentioned in main.tf in the module terrahouse_aws
    }
    ```
1. Providers used in the modules can imported via `main.tf` in the modules. The same don't have to mentioned in the `main.tf` at `PROJECT ROOT`.

> Dont copy paste the codes as it is. As the codes belong to two different file.


## Consideration when using ChatGPT to write terraform

LLMs such as ChatGPT may not be trained on the latest documentation or information about terraform.

It may likely produce older example that could be decrepated. 

## Working with files in Terraform

### Path Variable

In terraform, there is a special variable called `path` that allows us to reference local paths:
- `path.module` = get the path for the current module.
- `path.root`   = get the path for the root module.

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

[S3 object reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object)

[filemd5 reference](https://developer.hashicorp.com/terraform/language/functions/filemd5)
```hcl
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  # source = "/workspace/terraform-beginner-bootcamp-2023/public/index.html"
  # source = "${path.root}/public/index.html"
  source = var.index_html_filepath

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.index_html_filepath)
}
```

## AWS CloudFront Intergration.

Amazon CloudFront is a content delivery network operated by Amazon Web Services. The content delivery network was created to provide a globally-distributed network of proxy servers to cache content, such as web videos or other bulky media, more locally to consumers, to improve access speed for downloading the content.

For this project, we are going to use the website in S3 bucket via Amazon Cloudfront. The same can be added to Terraform through AWS provider.

For more information, please visit [Terraform: AWS Cloudfront Distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)

### Origin Access Control (OAC) 

CloudFront provides two ways to send authenticated requests to an Amazon S3 origin: origin access control (OAC) and origin access identity (OAI). For this project, we are going to use [Origin Access Control (OAC)](https://aws.amazon.com/blogs/networking-and-content-delivery/amazon-cloudfront-introduces-origin-access-control-oac/)

For more information, please visit [restricting access to an Amazon S3 origin](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html) documentation.

## Terraform Data Sources

Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.

A data source is accessed via a special kind of resource known as a data resource, declared using a data block:

For more information, please visit [Data Sources](https://developer.hashicorp.com/terraform/language/data-sources) documentation.


## Terraform Locals

Locals allows us to define local variables.
It can be very useful when we need transform data into another format and have referenced a varaible.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
For more information, please visit [Local Values](https://developer.hashicorp.com/terraform/language/values/locals) documentation


## Working with JSON

We use the jsonencode to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

For more information, please visit [jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode) documentation

## Working with Terraform Lifecycles

The Resource Behavior page describes the general lifecycle for resources. Some details of that behavior can be customized using the special nested lifecycle block within a resource block body.

lifecycle is a nested block that can appear within a resource block. The lifecycle block and its contents are meta-arguments, available for all resource blocks regardless of type. 

The arguments available within a lifecycle block are `create_before_destroy`, `prevent_destroy`, `ignore_changes`, and `replace_triggered_by`.

For more information please visit [Terraform Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

we are using a lifecycle with tag `replace_triggered_by` in this project. 
1. We will want to ignore the etag when triggerring the terraform update/plan for every single correction made to file.
1. We want the files to shown in the terraform plan, only when the content version has been changed.

## Terraform Data Block.

Before Null Provider were used as provided for maintaining a state for change in state for file as content management. Now, terraform has already included the provider as [`terraform_data`](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

The terraform_data implements the standard resource lifecycle, but does not directly take any other actions. You can use the terraform_data resource without requiring or configuring a provider. It is always available through a built-in provider with the source address terraform.io/builtin/terraform.

The terraform_data resource is useful for storing values which need to follow a manage resource lifecycle, and for triggering provisioners when there is no other logical managed resource in which to place them.