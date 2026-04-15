# rwf-container-build-and-push

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../.github/workflows/rwf-container-build-and-push.yaml](../../.github/workflows/rwf-container-build-and-push.yaml)

## Purpose

Builds a container image from a Dockerfile and pushes it to GitHub Container Registry.

## When To Use

Use this to build the container image that other reusable workflows run inside, or to publish a project image to GHCR.

## Usage

```yaml
jobs:
  container-build-and-push:
    uses: ./.github/workflows/rwf-container-build-and-push.yaml
    with:
      dockerfile: ./.devcontainer/Dockerfile
      image_name: cicd
      image_tag: dev
      platforms: linux/amd64
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `dockerfile` | No | `./.devcontainer/Dockerfile` | Dockerfile to build. |
| `image_name` | No | `${{ github.event.repository.name }}` | Image name portion of the final GHCR tag. |
| `image_tag` | No | empty string | Explicit image tag. If omitted, the workflow hashes the Dockerfile contents. |
| `platforms` | No | `linux/amd64` | Comma-separated build platforms for Buildx. |

## Secrets

This workflow does not define any `workflow_call` secrets.

## Outputs

| Name | Description |
| --- | --- |
| `container_image` | Full published image reference in `ghcr.io/<owner>/<image>:<tag>` format. |

## Notes

- The workflow logs in to `ghcr.io` with `secrets.GITHUB_TOKEN`; no Docker Hub secret is needed.
- The workflow interface now only exposes GHCR-oriented inputs: Dockerfile path, image name, image tag, and target platforms.
- This is the standard entry point used before the Python and Terraform workflows in this repository.
- The bundled caller example is [../../.github/workflows/wf-container-build-and-push.yaml](../../.github/workflows/wf-container-build-and-push.yaml).