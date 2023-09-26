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
- **[Refactoring into Bash Scripts](#refactoring-into-bash-scripts)**
   - **[Bash Execution considerations ](#bash-execution-considerations)**
- **[Changing `init` to `before` in gitpod `.yml`](#changing-init-to-before-in-gitpod-yml)**


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



## Changing `init` to `before` in gitpod `.yml`

**Execution order**

With Gitpod, you have the following three types of tasks:

- `before`: Use this for tasks that need to run before init and before command. For example, customize the terminal or install global project dependencies.
- `init`: Use this for heavy-lifting tasks such as downloading dependencies or compiling source code.
- `command`: Use this to start your database or development serve

Since we have to global dependencies like _**terraform cli, aws cli, etc.,**_ in gitpod workspace so we can use `before` instead of `init` command in `.yml` file.

For more information please visit **[Gitpod Workspace Task](https://www.gitpod.io/docs/configure/workspaces/tasks)** Documents
