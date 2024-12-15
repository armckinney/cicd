# Development

## Tools

- Docker Engine
- Rancher Desktop
- VS Code
  - Extension(s): Remote Development

Quick Installs (MacOs):

```bash
#/bin/zsh

brew update
brew install --cask visual-studio-code
# NOTE: you might have to add code command to your path before executing the following
code --install-extension ms-vscode-remote.vscode-remote-extensionpack
brew install docker docker-compose docker-credential-helper
brew install --cask rancher
```

You can open a project directory in VS Code (`code /path/to/repository/root`)
and an then you can use Development Containers (apart of Remote Development
extension pack) to open the project in the development container
(`Dev Container: Open in Container`).

## To create Terraform Documentation

terraform-docs uses the `.terraform-docs.yml` configuration files to execute.
These are each located in the parent directory of associated execution.

```bash
# docs for modules
cd terraform/modules && terraform-docs .

# docs for configurations
cd terraform/configurations && terraform-docs .
```

## Lifecycle

1. Capture work via Jira Task/Request and process task via Jira workflow
2. Make a development branch
3. Develop changes to branch, making incremental pushes to ensure persistence
4. Changes should be tested locally against existing infrastructure in the
Infrastructure Development account
5. When satisfied with the changes, developers should ensure that the existing
IaC on main is reflected in the IaC Dev Account via either locally deployment
or CICD deployment
6. Create a PR
7. CICD tooling will run static analysis and planning jobs of the development
source against the IaC Development account which has the main branch’s IaC -
this will replicate what deployments should occur within the non-dev accounts
8. After verifying the dev plan in the CICD pipeline, devs should test the
deployments by executing a Terraform Apply stage
9. Developers should test the IaC changes in the IaC Dev account for anything
necessary - networking, access, governance, security, etc.
10. When satisfied with all changes and the PR is ready for review, developers
should delete the IaC Dev resources by executing a Terraform Destroy stage and
 requesting review

## Naming Conventions

Terraform Address Naming Convention: terraform addresses should follow a
convention to make navigating terraform code more simple.
For resources where there is only a SINGLE resource of a given type defined a
the configuration:

```tf
resource "resource_type" "this" {}
```

For resources where there are multiple resources of a given type defined in a configuration:

```tf
# NOTE: "specific_identifier" might be a name like "data_science", where the 
object address would then become resource_type.data_science
resource "resource_type" "specific_identifier" {}
```

For resources where there are multiple resources defined in a single block
through the means of iteration:

```tf
resource "resource_type" "these" {
 for_each = ...
}
```

Resource Naming Convention: resources deployed to AWS should follow a naming
convention. Other resources should also consider a similar naming convention
when possible.

`<resource_type>-<workload>-<environment>`

Alternative Resource Naming Convention: alternatively, you can append a region
and instance if these are intended to be scoped to the resource type / within
DraftKings’ cloud scope

`<resource_type>-<workload>-<environment>-<region>-<instance>`

Resource type acronyms should follow AWS documentation: <https://docs.aws.amazon.com/whitepapers/latest/cicd_for_5g_networks_on_aws/acronyms.html>

## File Structure and Standards

Proposed structure of terraform projects follows a combination of best practices
 of Digital Ocean, Google, and DraftKings, and Databricks guidelines:

- Digital Ocean (directory structure): <https://www.digitalocean.com/community/tutorials/how-to-structure-a-terraform-project>
- Google (Required Terraform files): <https://cloud.google.com/docs/terraform/best-practices/general-style-structure>
- DraftKings: <https://confluence.dkcorpit.com/display/DD/Workspace+Terraform+Knowledge+Guide>
- Databricks: <https://github.com/databricks/terraform-databricks-examples/tree/main/examples/aws-workspace-uc-simple>

Note the change from “applications” to “configurations” to match Terraform syntax.

```text
.
├── .gitignore
├── README.MD (project documentation)
├── Dockerfile
├── .devcontainer/ (optional: implementing dev containers)
│   ├── Dockerfile
│   └── devcontainer.json
├── .vscode/ (optional: configuring custom vscode settings)
│   └── settings.json
├── ci/ (contains all cicd files)
│   └── ...
└── terraform/
    ├── scripts/ (optional: all terraform-executed scripts)
    ├── helpers/ (optional: all non-terraform-executed scripts)
    ├── modules/ (all local modules)
    │   ├── module_a/
    │   │   ├── TERRAFORM.md (module documentation)
    │   │   ├── main.tf (providers, versions, module calls)
    │   │   ├── variables.tf (all module variables)
    │   │   ├── outputs.tf (all module outputs)
    │   │   ├── resource_type_a.tf (all type_a resources)
    │   │   └── ...
    │   └── module_b/
    │       └── ...
    └── configurations/ (root directory of all configurations)
        ├── configuration_a/
        │   ├── env/ (deployment environment variables)
        │   │   ├── dev.tfvars
        │   │   ├── dev.tfbackend
        │   │   ├── prod.tfvars
        │   │   ├── prod.tfbackend
        │   │   └── ...
        │   ├── TERRAFORM.md (configuration docs)
        │   ├── main.tf (all providers with versions)
        │   ├── locals.tf (all local variables)
        │   ├── variables.tf (all configuration input variables)
        │   ├── outputs.tf (all configuration outputs)
        │   ├── data.tf (optional: all data blocks if many)
        │   ├── .imports.tf (optional: all configuration imports)
        │   ├── resource_type_a.tf (all type_a resources)
        │   ├── resource_type_b.tf
        │   └── ...
        └── configuration_b/
            ├── backend/
            ├── env/
            └── ...
```

# AWS Credentialing

AWS credentials of your host machine are mounted and exposed into the container in [docker-compose.yml](../docker-compose.yml) and the default AWS profile is set in the [Dockerfile](../.devcontainer/Dockerfile).
