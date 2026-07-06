---
name: rwf-creation
description: Specialized instructions and checklist for autonomous agents to create and chain Reusable Workflows (RWFs) and custom actions.
---

# Reusable Workflow Creation Skill

This skill guides you through the process of creating, structuring, and referencing Reusable Workflows (RWFs) and Custom Actions in this repository.

---

## 1. Classify the Workflow/Action Type

Before writing any YAML, determine where the component fits in the repository's Three-Tier Architecture:

| Tier | Component Type | Target Directory | Description |
|---|---|---|---|
| **Tier 1** | Custom Action | `.github/actions/<category>/<action-name>/` | Atomic step execution (e.g. `go/test`, `terraform/fmt`). |
| **Tier 2** | Atomic Workflow | `.github/workflows/rwf-<domain>-<task>.yaml` | Orchestrates Tier 1 actions. Defines OS, runner, permissions, secrets. |
| **Tier 3** | Composite Workflow | `.github/workflows/rwf-<domain>-deployment-ci.yaml` | Recursively chains multiple Tier 2 workflows. |

---

## 2. Implementation Guide

Follow these rules when implementing each tier:

### Creating a Tier 1 Custom Action (Composite Action)
* Must use `using: composite`.
* Do not specify jobs, runner OS, or triggers.
* If calling a sibling setup action (e.g. `setup` from `bump`), reference it using the checked-out path:
  ```yaml
  - name: Set up Verge CLI
    uses: ./.github/cicd/.github/actions/verge/setup
  ```

### Creating a Tier 2 Atomic Workflow
* Must define `workflow_call:` under `on:`.
* In each job executing local custom actions, check out the CI/CD library first:
  ```yaml
  steps:
    - name: Checkout repository
      uses: actions/checkout@v4

    - name: Checkout CICD library
      uses: armckinney/cicd/.github/actions/github/checkout-cicd-library@main
  ```
  *(Ensure there is exactly one blank line before and after this step for spacing consistency).*
* Call the custom action from the checked-out folder:
  ```yaml
  - name: Run Terraform Format
    uses: ./.github/cicd/.github/actions/terraform/fmt
  ```

### Creating a Tier 3 Composite Workflow
* Do not run custom actions directly if they are already orchestrated by Tier 2 workflows.
* Chain Tier 2 workflows recursively using relative paths:
  ```yaml
  jobs:
    static-analysis:
      uses: ./.github/workflows/rwf-terraform-static-analysis.yaml
      with:
        configuration: ${{ inputs.configuration }}
  ```
* Connect jobs sequentially using `needs:` to handle workflow dependencies.

---

## 3. Post-Creation Verification Checklist

1. **Verify Line Spacing:** Ensure there is exactly one blank line between steps in all modified workflow files.
2. **Verify References:**
   * No `@main` pins for internal action/workflow calls (except for the bootstrap `checkout-cicd-library@main` step).
   * All custom actions use the `./.github/cicd/` prefix.
   * All reusable workflows use relative paths (`./.github/workflows/`).
3. **Verify Documentation:** Ensure the new workflow is documented and tracked.
