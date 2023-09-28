# Terraform Beginner Bootcamp 2023


### List of Docs

- **[Assistance in Markdown format & Github Actions in a documentation](/DOC-MD-GITHUB-HELP.md)**
- **[Semantic Versioning](#semantic-versioning)**
- **[Linux Help Doc](#linux-help-doc)** 
   - **[Linux versions & Distrubutions](#linux-versions--distrubutions)**
   - **[Shebang](#shebang)**
   - **[Linux File Permissions](#linux-file-permissions)**
- **[Terraform CLI](#terraform-cli)**
   - **[Consideration with the Terraform CLI changes](#consideration-with-the-terraform-cli-changes)**
- **[Terraform Basics](#terraform-basics)**
   - **[Terraform Registry](#terraform-registry)**
      - **[Random Provider](#random-provider)**
      - **[AWS Provider](#aws-provider)**
   - **[Using Terraform](#using-terraform)**
   - **[Terraform files](#terraform-files)**
   - **[Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)**
- **[Refactoring into Bash Scripts](#refactoring-into-bash-scripts)**
   - **[Bash Execution considerations ](#bash-execution-considerations)**
- **[Changing `init` to `before` in gitpod `.yml`](#changing-init-to-before-in-gitpod-yml)**
- **[Environment Variable](#environment-variable-env)**
   - **[Filter Environment Variable](#filter-environment-variable)**
   - **[Setting and Unseting of Environment Variable](#setting-and-unseting-of-environment-variable)**
   - **[Scope of Environment variables](#scope-of-environment-variables)**
   - **[Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)**
- **[AWS CLI Installation](#aws-cli-installation)**

## Semantic Versioning

In Semantich Versioning ``2.0.0``, the projects are given a version number _**MAJOR.MINOR.PATCH**_, which are incremented if it falls in the below catergory:

1. **MAJOR** version when you make incompatible API changes
1. **MINOR** version when you add functionality in a backward compatible manner
1. **PATCH** version when you make backward compatible bug fixes

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

Please visit [https://semver.org/](https://semver.org/) for reference.

## Linux Help Doc
### Linux versions & Distrubutions

This product is build against Ubuntu Distribution

We can find the linux version using the commands

- `uname -srm`  
   ```bash
      $ uname -srm

      # output
      Linux 6.1.54-060154-generic x86_64
   ```

- `lsb_release -a`
   ```bash
      $ lsb_release -a

      # output
      No LSB modules are available.
      Distributor ID: Ubuntu
      Description:    Ubuntu 22.04.3 LTS
      Release:        22.04
      Codename:       jammy
   ```
- `cat /etc/os-release`
   ```bash
      $ cat /etc/os-release

      # output
      PRETTY_NAME="Ubuntu 22.04.3 LTS"
      NAME="Ubuntu"
      VERSION_ID="22.04"
      VERSION="22.04.3 LTS (Jammy Jellyfish)"
      VERSION_CODENAME=jammy
      ID=ubuntu
      ID_LIKE=debian
      HOME_URL="https://www.ubuntu.com/"
      SUPPORT_URL="https://help.ubuntu.com/"
      BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
      PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
      UBUNTU_CODENAME=jammy
   ```

### Shebang

A shebang is used as if it is an executable in a Unix-like operating system, the program loader mechanism parses the rest of the file's initial line as an interpreter directive and The loader executes the specified interpreter program. 


- `#!/bin/sh` – Execute the file using the Bourne shell, or a compatible shell, assumed to be in the /bin directory
- `#!/bin/bash` – Execute the file using the Bash shell
- `#!/usr/bin/pwsh` – Execute the file using PowerShell
- `#!/usr/bin/env python3` – Execute with a Python interpreter, using the env program search path to find it
- `#!/bin/false` – Do nothing, but return a non-zero exit status, indicating failure. Used to prevent stand-alone execution of a script file intended for execution in a specific context, such as by the . command from sh/bash, source from csh/tcsh, or as a .profile, .cshrc, or .login file.

It is used for better portability and can be used in different interpreters like `.sh, .zsh, etc`

For more information, please visit [Shebang (Wiki)](https://en.wikipedia.org/wiki/Shebang_(Unix))


### Linux File Permissions

The permissions of File and folders can be check with ``ls -l`` cmd in terminal. For more details visit **[File System Permission](https://en.wikipedia.org/wiki/File-system_permissions)** Wiki.


| Symbolic notation  | Numeric notation	|  English  
| -----------------  | ----------------   | --------  
| ----------         |	0000              |	no permissions
| -rwx------         |	0700              |	read, write, & execute only for owner
| -rwxrwx---         |	0770              |	read, write, & execute for owner and group
| -rwxrwxrwx         |	0777              |	read, write, & execute for owner, group and others
| ---x--x--x         |	0111              |	execute
| --w--w--w-         |	0222              |	write
| --wx-wx-wx         |	0333              |	write & execute
| -r--r--r--         |	0444              |	read
| -r-xr-xr-x         |	0555              |	read & execute
| -rw-rw-rw-         |	0666              |	read & write
| -rwxr-----         |	0740              |	owner can read, write, & execute; group can only read; others have no permissions


For changing the file permission type, you can use chmod command. For details visit **[chmod](https://en.wikipedia.org/wiki/Chmod) wiki**

```bash
   $ chmod 744 ./bin/file.name
```

Alternatively we can use

```bash
   $ chmod u+x ./bin/file.name
```

## Terraform CLI

To use Terraform you will need to install Terraform CLI. HashiCorp distributes Terraform as a binary package. You can also install Terraform using popular package managers.
### Consideration with the Terraform CLI changes 

The Terraform CLI installation instruction have changed due to gpg keyring changes.
So we needed to refer the latest install CLI instructions via [terraform documentation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

The commands for Debian/Ubuntu are given below:
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

# Install the HashiCorp GPG key.

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

# we can verify the hash key's install with by command given below:

gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

# Add the official HashiCorp repository to your system. 

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform
```

> Note: If requried, we can also use apt instead of apt-get


## Terraform Basics
### Terraform Registry

Terraform Registry has all type of **Providers** and **Modules**

**Providers** - Used for directly intergrate API of all Services in Cloud Service Providers (like, AWS, AZURE, etc)
**Modules** - It is collection of templates commonly used in Terraform 

For more information, visit [Terraform Registry](https://registry.terraform.io/)

### List of Terraform Providers

For this bootcamp, we will use the following providers

#### **[Random Provider](https://registry.terraform.io/providers/hashicorp/random/latest)**

To use configuration, from [Random Provider Documentation](https://registry.terraform.io/providers/hashicorp/random/latest/docs) and by clicking use provider button, it will give the below code.

```sh
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}
```

Then paste the resource, from the examples in the documention.

```sh
resource "random_string" "bucket_name" {
  length           = 16
  special          = false
 #   override_special = "/@£$"
}
```

Now, you can save [output](https://developer.hashicorp.com/terraform/language/values/outputs) to a varible in the same tf file.  

```sh
output "random_bucket_name_id" {
  value = random_string.bucket_name.id
}

output "random_bucket_name_result" {
  value = random_string.bucket_name.result
}

```

#### **[AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest)**


To use configuration, from [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) and by clicking use provider button, it will give the below code.

```json
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.18.1"
    }
  }
}

provider "aws" {
  # Configuration options
}
```

Add AWS Configuration:

For example:

```json
provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

```



### Using Terraform

Terraform should be used by following commands

 - `init`          
   - Prepare your working directory for other commands. 
   - Initialize the backend in the project. Also downloads the provider from terraform registry and initialize it in the project.  
 - `validate`      
   - Check whether the configuration is valid
 - `plan`          
   - Show changes required by the current configuration
   - It shows changes made to resources from last configuration which you can check for any unplanned change that going to happen to resource. If it is new configuration, it will shows the resources added to the project.
 - `apply`         
   - Create or update infrastructure
   - This will apply the change
   - The change can be auto approved by flag `--auto-approve`. Example `terraform apply --auto-approve`
 - `destroy`       
   - Destroy previously-created infrastructure

The above main commands are mainly used in terraform. eg. `terraform init`


### Terraform files .

`.terraform.lock.hcl` contains the locked versioning for the provided and modules used in this project. **This file should be commited**.

`terraform.tfstate` &  `terraform.tfstate.backup` are used for maintaining state for the project.

> This files should not be committed to project.

### Issues with Terraform Cloud Login and Gitpod Workspace.

When attempting to run `terraform login` it will launch bash a wiswig view to generate a token. However, it does not work expected in Gitpod VS Code in the browser.

You have to create token manually from profile page.

- Enter `terraform login`
- Then `yes`
- Then `O`
- Then `Q`

   ```sh
   Token for app.terraform.io:
  Enter a value: 
   ```
- Then paste the value of token
- Then you will be sucessfully logged in.


We have automated this workaround with the following bash script [generate_trfc_credentials](./bin/generate_tfrc_credentials)
## Refactoring into Bash Scripts

While fixing the Terraform install issue due to gpg depreciation. we notice that creating bash scripts were more in the documentation as compared to before.
so, we decided to create bash script to install the terraform CLI.

We are creating the bash scripts for running instead of pasting it in the yaml file. [All Scripts](./bin)


- This will keep the gitpod task file [.gitpod.yml](.gitpod.yml) tidy
- This allow us an easier to debug and manually execute terraform cli install
- Also, this will allow better portability for other projects that need to install Terraform CLI

For this project we are using bash, so the file start with `#!/usr/bin/env bash` 

For example: 
```bash

#!/usr/bin/env bash`

sudo apt update

```

### Bash Execution considerations 

When executing the bash script we can use the `./` short hand notation to execute the bash script.

eg. ` ./bin/install_terraform_cli` 

> Before running the script we have change the permission as mentioned in the [Linux File permissions](#linux-file-permissions)

If we are using a script in .gitpod.yml, we need to point the script to a program to interpret it.

 ```bash
$ source ./bin/install_terraform_cli
 ```

### Bash Profiles

The Bash Profile file can be openned in VSCode

```sh
open ~/.bash_profile
```

## Changing `init` to `before` in gitpod `.yml`

**Execution order**

With Gitpod, you have the following three types of tasks:

- `before`: Use this for tasks that need to run before init and before command. For example, customize the terminal or install global project dependencies.
- `init`: Use this for heavy-lifting tasks such as downloading dependencies or compiling source code.
- `command`: Use this to start your database or development serve

Since we have to global dependencies like _**terraform cli, aws cli, etc.,**_ in gitpod workspace so we can use `before` instead of `init` command in `.yml` file.

For more information please visit **[Gitpod Workspace Task](https://www.gitpod.io/docs/configure/workspaces/tasks)** Documents


## Environment Variable `.env`

Environment variables (env var) allow us to keep values on our local and production environments distinct and safe as we develop our app. We can understand an environment as the context in which code is being executed—all the variables, objects, functions available to the code.

The general convention for naming of env variables are that it should be all capital letter with underscore (`_`) in between instead of spaces.

We can see all the env var by entering `env` in the terminal.

### Filter Environment Variable

If you want to search/filter a specific env var in the data, you can do it by passing the output of `env` to `grep` command via `|` and entering the value to search in the data as given below.

```bash  
   env | grep terraform-beginner-bootcamp
```

### Printing of Environment variables
You can print / `echo` out a specific env var by entering the name of env with $ before it.

```bash
echo $THEIA_WORKSPACE_ROOT
```

Alternatively you can also use grep 

```bash  
   env | grep $THEIA_WORKSPACE_ROOT
```

### Setting and Unseting of Environment Variable

You can set a `env var` by type the export it in the terminal as given below.

```bash
export PROJECT_ROOT='/workspace/terraform-beginner-bootcamp-2023'
```

You can also unset the `env var` by entering unset commant in the terminal

```bash
unset PROJECT_ROOT
```

We can set an env var temporarily just by running a command.

```bash
Hello='world' ./bin/print message
```

Within a bash script we can set env without writing export as given below:

```sh
#!/usr/bin/env bash

Hello='world'

echo $HELLO
```

### Scope of Environment variables

Environment variables are local to the process in which they were set. If two shell processes are spawned and the value of an environment variable is changed in one, that change will not be seen by the other.

If you want the Env Vars to persist across all future bash terminals that are open ypu need to set env vars in your bash profile. eg. `.bash_profile`

### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```sh
gp env HELLO='world'
```

All future workspaces will set the env vars for all bash terminals opened in those workspaces

You can also set an vars in the `.gitpod.yml` but this can only contain non-senstive env vars.

> It is not recommended to use set vars in the `.gitpod.yml`

## AWS CLI Installation

AWS ClI is installed for the project via the bash script [./bin/install_aws_cli](./bin/install_aws_cli)

For more information, visit [Getting started - AWS CLI install and update instructions ](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)


After installation, if you enter aws and press enter then we will get pop up 

> Popup for CLI is shown due the setting `partial` in `.gitpod.yml`

we can check if our AWS credentials is configured by entering the below command:

```bash
aws sts get-caller-identity
```

If the command is successful, you should see a json paylod return that looks like below:

```json
{
    "UserId": "AIDAVI7XFDJGLHWHT644P",
    "Account": "363906212345",
    "Arn": "arn:aws:iam::363906212345:user/terraform-beginner-bootcamp"
}

```