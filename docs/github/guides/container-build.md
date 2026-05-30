# Container Build Pipelines Guide

This guide describes how to configure container image build and push pipelines to securely build, tag, and publish Docker images to container registries (such as GHCR, DockerHub, or Azure Container Registry).

## Use Case

When developing containerized applications or custom runner environments, you need a pipeline that:
1. Triggers on changes to application code or Dockerfiles.
2. Leverages container caching to speed up builds.
3. Automatically derives clean, unique tags (e.g. branch names, SHA, or semantic versions).
4. Skips the build if the tag already exists (avoiding accidental overwrites of stable releases).
5. Seamlessly logs in and pushes to your target container registry.

## Workflow Implementation

Here is an example setup using the reusable container build workflow (`rwf-container-build-and-push.yaml`):

```yaml
name: Build and Push Application Container

on:
  push:
    branches: [ main ]
    tags: [ 'v*.*.*' ]
  pull_request:
    branches: [ main ]

jobs:
  # Job to build and push container images
  publish-container:
    uses: ./.github/workflows/rwf-container-build-and-push.yaml
    with:
      # Optional: The repository where the image should be published
      # Defaults to the GitHub Container Registry: ghcr.io/<owner>/<repo>
      image_name: 'ghcr.io/armckinney/app-service'
      
      # Optional: Set to true if you want to force-build and overwrite tags
      # Set to false to avoid overwriting stable releases
      overwrite: ${{ github.event_name == 'pull_request' }}
      
      # Optional: Pass custom external build-args
      build_args: |
        ENVIRONMENT=production
        API_VERSION=v2
```

## How It Works Under the Hood

The container build reusable workflow leverages:
1. **GitHub Actions runner context**: Automatically authenticates to the local GitHub Container Registry (`ghcr.io`) using the standard `secrets.GITHUB_TOKEN`.
2. **Buildx and Cache Mounts**: Standardizes cache storage inside GitHub Actions Cache, speeding up consecutive image rebuilds significantly.
3. **Overwrite Prevention**: Checks if the tag already exists in the destination registry. If it does and `overwrite` is `false`, the workflow cleanly exits without running expensive build stages.

## Advanced Registry Configs
To push to alternative registries like Azure Container Registry (ACR) or DockerHub:

```yaml
jobs:
  custom-registry-build:
    uses: ./.github/workflows/rwf-container-build-and-push.yaml
    with:
      image_name: 'myregistry.azurecr.io/web-app'
      overwrite: true
    secrets:
      # Pass custom registry credentials via secrets
      REGISTRY_USERNAME: ${{ secrets.ACR_USERNAME }}
      REGISTRY_PASSWORD: ${{ secrets.ACR_PASSWORD }}
```
