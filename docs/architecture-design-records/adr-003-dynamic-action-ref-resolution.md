# ADR 003: Dynamic CI/CD Actions Ref Resolution

* **Status**: Accepted
* **Date**: 2026-07-06
* **Author**: Agent

## Context

This repository (`armckinney/cicd`) hosts central reusable workflows (RWFs) and custom composite actions consumed by other repositories (such as `infrastructure`). 

GitHub Actions resolves relative action paths (e.g. `uses: ./.github/actions/terraform/fmt`) relative to the **caller repository's** workspace. Since the caller repositories do not contain these action files, external runs fail.

To resolve this, workflows must reference custom actions absolutely (`uses: armckinney/cicd/...@main`). However, hardcoding absolute refs to `@main` prevents developers from dynamically testing changes to actions on feature branches or pull requests within this repository (since the workflow will always download the action from `main` instead of the current development branch).

We need a solution that:
1. Dynamically resolves references to the correct branch/tag/ref.
2. Works seamlessly for both external consumers and local PR testing.
3. Minimizes code duplication and developer overhead.

## Decision

We will adopt a **self-resolving bootstrap checkout strategy** for all reusable workflows that run local actions:

1. **Dynamically Resolve the Ref**: We extract the current branch/tag/ref of the called reusable workflow using GitHub's built-in `job.workflow_ref` context property, which contains the exact path and ref of the executing reusable workflow.
2. **Modularize Checkout**: We create a dedicated bootstrap composite action, `armckinney/cicd/.github/actions/github/checkout-cicd-library@main`, which extracts this ref and checks out the `cicd` repository to `.github/cicd/` in the runner's workspace.
3. **Reference Actions Relatively**: All jobs in reusable workflows (`rwf-*.yaml`) that execute custom actions will call the bootstrapper first, and then call the actions from the checked-out folder:
   ```yaml
   - name: Checkout repository
     uses: actions/checkout@v4

   - name: Checkout CI/CD
     uses: armckinney/cicd/.github/actions/github/checkout-cicd-library@main

   - name: Terraform format
     uses: ./.github/cicd/.github/actions/terraform/fmt
   ```
4. **Sibling Composite Actions**: Custom actions calling other sibling custom actions will reference them using the checked-out directory (`uses: ./.github/cicd/.github/actions/verge/setup`) to ensure they remain portable and resolve to the correct branch.
5. **Sibling Reusable Workflows**: Reusable workflows calling other reusable workflows in this repository will use relative paths (e.g., `uses: ./.github/workflows/rwf-terraform-plan.yaml`). GitHub Actions natively resolves sibling reusable workflows relative to the same commit/ref as the parent workflow.

## Consequences

* **Positive**:
  * **Dynamic Branch Testing**: Pull requests and development branches in this repository are tested automatically and dynamically with their local custom action code.
  * **Zero Developer Concerns**: Developers simply write and push code; the CI/CD pipeline dynamically handles path and ref resolution without manual branch/version overrides.
  * **Clean Codebase**: Consolidates the checkout and ref resolution logic into a single modular bootstrap action.
  * **No File Clashing**: Checking out the library into `.github/cicd/` keeps the files scoped and hidden. Compilers, package managers, and test runners ignore this folder, preventing pollution of the caller's codebase.
* **Negative/Neutral**:
  * **Runner Overhead**: Adds a minor execution delay (~2 seconds) per job to perform the bootstrap checkout.
  * **Bootstrapper Pinning**: The `checkout-cicd-library` action call itself must be pinned to `@main` (or a tag). Any structural changes to the bootstrapper's own logic cannot be tested dynamically on a branch, but this logic is highly static and simple.
