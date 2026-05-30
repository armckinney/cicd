# releaser

This document describes the local composite action to run **GoReleaser**.

Action file: [../../../../.github/actions/go/releaser/action.yaml](../../../../.github/actions/go/releaser/action.yaml)

## Purpose

Runs GoReleaser to compile Go binaries for multiple architectures/operating systems, package them, and publish release artifacts (including checksums and changelogs) to GitHub Releases.

## When To Use

Use this action in CD (Continuous Delivery) release pipelines to automate the distribution of Go applications.

## Usage

```yaml
- name: Run GoReleaser
  uses: ./.github/actions/go/releaser
  with:
    github-token: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `version` | No | `latest` | The GoReleaser version to use (e.g. `latest` or `v2.0.0`). |
| `args` | No | `release --clean` | Arguments to pass to the GoReleaser CLI. |
| `github-token` | Yes | none | GitHub token with write permissions to create and update releases. |

## Notes

- Requires a valid Go environment to be set up on the runner first (e.g. using the Go `setup` action).
- Assumes a GoReleaser configuration file (e.g. `.goreleaser.yaml`) is located in the working directory or root of the repository.
