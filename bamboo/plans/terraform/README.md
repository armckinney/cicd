# CICD Pipeline Overview

The pipeline for this utilizes a generic Terraform workflow, as shown below.

![](../static/terraform_cicd-architecture.png)

## Bamboo Specs

The bamboo specs documentation can be found [here](https://docs.atlassian.com/bamboo-specs-docs/10.0.0/specs.html?yaml).

The specs in this repository is implemented in the following pattern for DRY and single-reposibility architecture.

- Bamboo Entrypoint: [bamboo.yaml](./bamboo.yaml)
- Bamboo Plans: [./plans/](./plans/)
  - Plans implement `stages`, `jobs`, and `branches` in the context of specific environments as well as define basic Bamboo plan configuration
- Branch Implementation:
  - Branches define the branching strategy of the plan.
  - Generally all repo branches map/can deploy to a dev plan, but all other environments can only deploy from the main branch.
  - A seperate branch is also maintained for bamboo development in particular, this is desirable since the implemented bamboo specs generally reference the main branch.
- Stage Implementations: [./stages/](./stages/)
  - Stages are a semi-defined plans which define the process of a plan, stages are not responsible for implementing `jobs`
- Job Implementations: [./jobs/](./jobs/)
  - Jobs are collections of tasks and indeed implement `tasks` which are executed in parallel. Each job is executed sequentially.
- Task Implementations: [./tasks](./tasks/)
  - Tasks are single units of work
- [bamboo-export-variables.txt](./bamboo-export-variables.txt)
  - This is a custom file in which can defines bamboo variables that we would like to export so they can be properly comsumed by terraform providers. The export is implemented via the [export-bamboo-varibles](./tasks/export-bamboo-varibles.yaml) task.
