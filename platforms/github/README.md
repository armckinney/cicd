Notes:
workflow consists of jobs, which in themselves are reusable workflows
jobs consist of steps
jobs are asyncronous and not dependant by default
steps are syncronous and dependant, steps can share data
steps are implemented via composite actions, which are reusable steps


Project Workflow -implements> Reusable Workflows -comprised of> Composite Actions
- Note: seperate reusable workflows by grouping
    - could be all-in-1 RFW (terraform-workflow)
    - could be seperate groups (static-analysis, terraform-action)


Project WF
[
    build (RWF) / container-build-and-push (CA)

    static-analysis (RWF) / terraform-lint (CA)
    - needs build
    static-analysis / terraform-format
    ....

    terraform-plan (CA)

    terraform-plan-approve (CA)

    terraform-action (RWF) / terraform-apply (job) -> cloud-configure(CA), terraform-init(CA), terraform-apply(CA)
    - needs terraform-plan-approve
    terraform-action / terraform-show
    terraform-action / terraform-destroy
]

current:
- uses: armckinney/cicd/src/github/workflows/terraform-actions.yaml
preferred:
- uses: armckinney/cicd/platforms/github/workflows/terraform-actions.yaml
