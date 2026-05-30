# Python Static Analysis Guide

This guide describes how to configure automated static analysis, linting, code formatting, and unit testing for Python applications using reusable GitHub workflows.

## Use Case

Maintaining a uniform code standard across a Python codebase prevents formatting debates, improves code readability, and catches syntax or import errors before code is pushed to production.

An automated Python quality pipeline should:
1. **Lint and Format**: Inspect formatting standards using tools like `black`, `flake8`, or `ruff`.
2. **Type Check**: Ensure static type consistency using `mypy`.
3. **Unit Test**: Run automated tests using `pytest` and output coverage details.

## Workflow Implementation

Here is an example setup using our reusable Python static analysis and test workflows:

```yaml
name: Python Quality Pipeline

on:
  pull_request:
    branches: [ main ]
    paths: [ '**.py' ]

jobs:
  # Job 1: Run Static Checks
  python-linting:
    uses: ./.github/workflows/rwf-python-static-analysis.yaml
    with:
      # Unified runtime container image including pre-installed tools
      container_image: 'ghcr.io/armckinney/python:3.12.3'
      
      # Optional: specify sub-folder containing target code
      working_directory: 'src/app/'

  # Job 2: Run Unit Tests (in parallel or sequentially)
  python-unit-tests:
    needs: [ python-linting ]
    uses: ./.github/workflows/rwf-python-test.yaml
    with:
      container_image: 'ghcr.io/armckinney/python:3.12.3'
      working_directory: 'src/app/'
```

## How It Works

* **`rwf-python-static-analysis.yaml`**: Runs within your specified container environment. It performs deep static scans including code formatting checks (`black --check .`), style/syntax scans (`flake8`), and security/complexity checks (if configured) on the codebase.
* **`rwf-python-test.yaml`**: Mounts workspace code, installs local dependencies, and runs `pytest` within the hermetic python container. This guarantees tests execute under the exact same package versions as production.
