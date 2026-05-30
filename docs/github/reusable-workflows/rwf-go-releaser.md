# rwf-go-releaser

This document describes the GoReleaser reusable workflow.

Reusable workflow file: [../../../.github/workflows/rwf-go-releaser.yaml](../../../.github/workflows/rwf-go-releaser.yaml)

## Purpose

Automates multi-platform building, packaging, checksum generation, changelog assembly, and release asset uploads using GoReleaser.

## When To Use

Use this in Go release CD pipelines to deploy standardized multi-architecture binaries and packages automatically.

## Usage

```yaml
jobs:
  go-releaser:
    uses: ./.github/workflows/rwf-go-releaser.yaml
    with:
      working_directory: '.'
      go_version: '1.22'
      goreleaser_version: 'latest'
      args: 'release --clean'
    secrets:
      token: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `working_directory` | No | `.` | Directory containing GoReleaser configuration. |
| `go_version` | No | empty string | The Go version to install. Defaults to reading from `go.mod`. |
| `goreleaser_version` | No | `latest` | The GoReleaser version to install. |
| `args` | No | `release --clean` | Arguments to pass to GoReleaser. |

## Secrets

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `token` | No | `github.token` | GitHub token with contents write permissions. |

## Outputs

This workflow does not publish outputs.

## What It Runs

- Performs standard checkout with full git tags history (`fetch-depth: 0`).
- Sets up Go environment via [setup action](../actions/go/setup.md).
- Runs GoReleaser via [releaser action](../actions/go/releaser.md).

## Notes

- Requires a valid GoReleaser configuration file (e.g. `.goreleaser.yaml` or `.goreleaser.yml`) at the root of your Go module.
