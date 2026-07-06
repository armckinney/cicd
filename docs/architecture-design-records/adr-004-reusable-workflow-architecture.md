# ADR 004: Reusable Workflow Architecture

* **Status**: Accepted
* **Date**: 2026-07-06
* **Author**: Agent

## Context

To manage CI/CD pipelines across multiple consuming repositories efficiently, we need to structure our GitHub Actions workflow logic. If pipelines are written monolithically:
1. Steps (like Terraform fmt/lint or Go test) are duplicated, leading to fragmentation and high maintenance overhead.
2. Custom actions cannot be tested dynamically on developer branches before merging to main.
3. Complex pipelines (e.g. static analysis -> build -> deploy) cannot be reused as unified workflows.

We need a standardized architecture that supports modularity, pipeline chaining, and dynamic branch testing.

## Decision

We will adopt a **three-tier reusable workflow and action architecture**:

1. **Tier 1 (Custom Actions)**: Atomic CLI operations (e.g. `terraform/fmt`) defined under `.github/actions/`.
2. **Tier 2 (Atomic Workflows)**: Reusable workflows (`rwf-*.yaml`) that orchestrate Tier 1 actions. They define runners, configurations, permissions, and secrets for a specific category (e.g., `rwf-terraform-static-analysis.yaml`).
3. **Tier 3 (Composite Workflows)**: Complex reusable workflows that call and chain Tier 2 workflows recursively (e.g. `rwf-terraform-deployment-ci.yaml` composing static-analysis, plan, and apply workflows).

To implement this hierarchy:
* Sibling composite action calls must use relative checked-out paths: `uses: ./.github/cicd/.github/actions/...`.
* Reusable workflows must chain other workflows using relative pathing: `uses: ./.github/workflows/rwf-...yaml`.
* Every job in a reusable workflow executing local actions must call `checkout-cicd-library@main` first.

## Consequences

* **Positive**:
  * **Modularity and DRYes**: Complete dry workflows (e.g., a standard Terraform CI pipeline can be composed of plans and applies without rewriting step logic).
  * **Testing Portability**: Sibling workflows and composite actions inherit the same execution branch dynamically.
  * **Separation of Concerns**: Secrets and environments are configured in the workflows (Tier 2/3), while execution logic is isolated in the actions (Tier 1).
* **Negative/Neutral**:
  * **File Proliferation**: Requires managing multiple YAML files for actions, workflows, and composite pipelines.
  * **Slight Overhead**: Minor delay in pipelines due to bootstrapper checkout steps.
