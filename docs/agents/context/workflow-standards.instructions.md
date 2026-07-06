---
name: Workflow and Action Standards
description: Rules and guidelines for referencing reusable workflows and custom actions.
applyTo:
  - ".github/workflows/**"
  - ".github/actions/**"
---

# Workflow and Action Standards

## Rule: Reusable Workflows (RWFs) Calling Custom Actions
When creating or modifying a reusable workflow (`rwf-*.yaml`) that executes custom composite actions from this repository, you must use the **self-resolving checkout strategy** to ensure they work both for external consumers and dynamically during PR/branch testing:
* Do not expose an `actions_ref` input parameter to the workflow call.
* In each job executing local actions, check out the CI/CD library into the `.github/cicd/` subdirectory by calling the bootstrapper action right after checking out the workspace:
  ```yaml
  - name: Checkout repository
    uses: actions/checkout@v4

  - name: Checkout CI/CD
    uses: armckinney/cicd/.github/actions/github/checkout-cicd-library@main
  ```
* Reference all custom actions in the workflow relative to the checked-out folder:
  ```yaml
  uses: ./.github/cicd/.github/actions/terraform/fmt
  ```

## Rule: Sibling Custom Action References (Composite Siblings)
When writing a custom composite action that references another sibling custom action in this repository (e.g., `verge/bump` calling `verge/setup`), you must reference the sibling action using the checked-out path:
* Format: `uses: ./.github/cicd/.github/actions/verge/setup`
* Do not use hardcoded absolute `@main` refs for sibling calls, as it prevents development changes from being tested dynamically.

## Rule: Nested Reusable Workflows
When calling a reusable workflow from another reusable workflow in this repository, you must use relative pathing:
* Format: `uses: ./.github/workflows/rwf-terraform-plan.yaml`
* Do not use absolute paths or specify branch tags for sibling reusable workflows. GitHub Actions natively resolves relative workflows to the same commit/ref as the parent workflow.
