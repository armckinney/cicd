# rwf-python-static-analysis

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../.github/workflows/rwf-python-static-analysis.yaml](../../.github/workflows/rwf-python-static-analysis.yaml)

## Purpose

Runs Python static analysis with Ruff linting, Ruff formatting checks, and `ty` type checking.

## When To Use

Use this early in a Python CI pipeline to fail fast on lint, formatting, and typing issues.

## Usage

```yaml
jobs:
  python-static-analysis:
    uses: ./.github/workflows/rwf-python-static-analysis.yaml
    with:
      container_image: ghcr.io/armckinney/python:3.12.3
      working_directory: tests/python/example
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `container_image` | Yes | none | Container image used to run the tools. |
| `working_directory` | No | `.` | Directory containing the Python project. |

## Secrets

This workflow does not define any `workflow_call` secrets.

## Outputs

This workflow does not publish outputs.

## What It Runs

- `uv run ruff check .`
- `uv run ruff format --check .`
- `uv run ty check .`

## Notes

- Each check runs in its own job inside the same supplied container image.
- The bundled caller example is [../../.github/workflows/wf-python-cicd.yaml](../../.github/workflows/wf-python-cicd.yaml).