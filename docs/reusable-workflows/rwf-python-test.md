# rwf-python-test

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../.github/workflows/rwf-python-test.yaml](../../.github/workflows/rwf-python-test.yaml)

## Purpose

Runs `pytest` in a supplied Python container image.

## When To Use

Use this in a Python CI pipeline after or alongside static analysis to execute the test suite.

## Usage

```yaml
jobs:
  python-test:
    uses: ./.github/workflows/rwf-python-test.yaml
    with:
      container_image: ghcr.io/armckinney/python:3.12.3
      working_directory: tests/python/example
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `container_image` | Yes | none | Container image used to run tests. |
| `working_directory` | No | `.` | Directory containing the Python project. |

## Secrets

This workflow does not define any `workflow_call` secrets.

## Outputs

This workflow does not publish outputs.

## What It Runs

- `uv run pytest .`

## Notes

- The bundled caller example is [../../.github/workflows/wf-python-cicd.yaml](../../.github/workflows/wf-python-cicd.yaml).