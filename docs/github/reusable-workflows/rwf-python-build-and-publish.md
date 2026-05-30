# rwf-python-build-and-publish

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../../.github/workflows/rwf-python-build-and-publish.yaml](../../../.github/workflows/rwf-python-build-and-publish.yaml)

## Purpose

Builds a Python package with `uv build` and optionally uploads the built artifacts to a GitHub release.

## When To Use

Use this after static analysis and tests when you want to validate packaging or publish release artifacts from `dist/`.

## Usage

```yaml
jobs:
  python-build:
    uses: ./.github/workflows/rwf-python-build-and-publish.yaml
    with:
      container_image: ghcr.io/armckinney/python:3.12.3
      working_directory: tests/python/example
      publish_tag: ci
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `container_image` | Yes | none | Container image used to run the build. |
| `working_directory` | No | `.` | Directory containing the Python project. |
| `publish_tag` | No | empty string | Git tag for the GitHub release. Leave empty to build only. |

## Secrets

This workflow does not define any `workflow_call` secrets.

## Outputs

This workflow does not publish outputs.

## Notes

- The job requires `contents: write` because it can upload files to a GitHub release.
- The publish step only runs when `publish_tag` is non-empty.
- The bundled caller example is [../../../.github/workflows/wf-python-cicd.yaml](../../../.github/workflows/wf-python-cicd.yaml).