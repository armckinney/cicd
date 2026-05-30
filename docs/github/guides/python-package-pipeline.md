# Python Package Pipeline Guide

This guide describes how to configure an automated pipeline to run static analysis, execute tests, compile distribution wheels/tarballs, and publish them to package registries (like PyPI or internal corporate repositories).

## Use Case

When developing shared libraries, utilities, or internal SDKs in Python, you want to automate the packaging and delivery cycle:
1. Verify code formatting and linting.
2. Confirm 100% test coverage and code correctness.
3. Automatically build distributions (`.whl` and `.tar.gz`).
4. Securely publish the artifacts when a production release tag is pushed.

## Workflow Implementation

Here is an example setup demonstrating a full build-and-publish package lifecycle:

```yaml
name: Build and Publish Python Package

on:
  push:
    tags:
      - 'v*.*.*' # Trigger publish only on semantic release tags

jobs:
  # Stage 1: Quality Checks
  static-checks:
    uses: ./.github/workflows/rwf-python-static-analysis.yaml
    with:
      container_image: 'ghcr.io/armckinney/python:3.12.3'

  unit-testing:
    uses: ./.github/workflows/rwf-python-test.yaml
    with:
      container_image: 'ghcr.io/armckinney/python:3.12.3'

  # Stage 2: Compilation and Publishing
  publish-package:
    needs: [ static-checks, unit-testing ]
    uses: ./.github/workflows/rwf-python-build-and-publish.yaml
    with:
      container_image: 'ghcr.io/armckinney/python:3.12.3'
      
      # Use PyPI or a custom artifact url
      repository_url: 'https://upload.pypi.org/legacy/'
    secrets:
      # Pass secret publishing tokens / credentials
      REPOSITORY_USERNAME: '__token__'
      REPOSITORY_PASSWORD: ${{ secrets.PYPI_API_TOKEN }}
```

## How It Works

* **Build Compilation**: The publishing workflow uses standard build modules (like `hatch`, `setuptools`, or `poetry`) inside the container to build source distributions (`sdist`) and binary distributions (`wheel`).
* **Registry Delivery**: It uses `twine` or package managers to publish compiled archives securely to PyPI or an internal registry (like Azure Artifacts or AWS CodeArtifact) using the provided token or API secrets.
