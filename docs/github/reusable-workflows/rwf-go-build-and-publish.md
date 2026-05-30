# rwf-go-build-and-publish

This document describes the Go building and release asset publishing reusable workflow.

Reusable workflow file: [../../../.github/workflows/rwf-go-build-and-publish.yaml](../../../.github/workflows/rwf-go-build-and-publish.yaml)

## Purpose

Compiles Go code to a specified output binary name and optionally uploads it as a release asset to a GitHub Release.

## When To Use

Use this in Go deployment, CI build validation, pre-release, or CD pipelines to produce compiled binaries and optionally distribute them on GitHub Releases.

## Usage

```yaml
jobs:
  go-build:
    uses: ./.github/workflows/rwf-go-build-and-publish.yaml
    with:
      working_directory: tests/go/example
      go_version: '1.22'
      packages: '.'
      output: 'hello-world-bin'
      publish_tag: 'v1.0.0'
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `working_directory` | No | `.` | Directory where Go code is located. |
| `go_version` | No | empty string | The Go version to install. Defaults to reading from `go.mod`. |
| `packages` | No | `./...` | The Go packages or entrypoint file to compile. |
| `output` | No | empty string | The relative path/filename for the built output binary. |
| `flags` | No | empty string | Additional compiler flags to pass (e.g. `-ldflags="-s -w"`). |
| `publish_tag` | No | empty string | Git tag to publish the compiled binary to (using GitHub Release). Leave blank to compile without publishing. |

## Secrets

This workflow does not define any `workflow_call` secrets.

## Outputs

This workflow does not publish outputs.

## What It Runs

- Sets up Go environment via [setup action](../actions/go/setup.md).
- Compiles package via [build action](../actions/go/build.md).
- Uploads compiled binaries as release assets via `softprops/action-gh-release@v2`.

## Notes

- The bundled caller example is [../../../.github/workflows/wf-go-cicd.yaml](../../../.github/workflows/wf-go-cicd.yaml).
