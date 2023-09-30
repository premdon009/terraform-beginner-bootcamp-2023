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