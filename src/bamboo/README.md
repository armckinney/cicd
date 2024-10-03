# CICD Pipeline Overview
The pipeline for this utilizes a generic Terraform workflow, as shown below.

![](../static/terraform_cicd-architecture.png)

## Bamboo Specs
The bamboo specs documentation can be found [here](https://docs.atlassian.com/bamboo-specs-docs/10.0.0/specs.html?yaml).

The specs in this repository is implemented in the following pattern for DRY and single-reposibility architecture.

- Bamboo Entrypoint: [bamboo.yaml](./bamboo.yaml)
    - This is composed of various Bamboo Plans.
- Bamboo Plans: [./plans/](./plans/)
    - Plans implement stages in the context of specific environments
- Stage Implementations: [./stages/](./stages/)
    - Stages are a semi-defined plans which define the stages and jobs which are needed
- Job Implementations: [./jobs/](./jobs/)
    - Jobs implement tasks which are executed in parallel. Each job is executed sequentially.
- Task Implementations: [./tasks](./tasks/)
    - Tasks are single units of work
