# setup

This document describes the local composite action to set up the **Go environment** on the runner.

Action file: [../../../../.github/actions/go/setup/action.yaml](../../../../.github/actions/go/setup/action.yaml)

## Purpose

Sets up a specific Go environment on the runner, including enabling dependency caching natively.

## When To Use

Use this action to initialize Go on the runner before compiling, testing, or linting Go code.

## Usage

```yaml
- name: Set up Go
  uses: ./.github/actions/go/setup
  with:
    go-version: '1.22'
    working-directory: '.'
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `go-version` | No | empty string | The Go version to install (e.g. `1.22`). |
| `go-version-file` | No | empty string | Path to a `go.mod` file to read the Go version from. Defaults to `<working-directory>/go.mod` if left empty. |
| `working-directory` | No | `.` | Working directory used for fallback `go.mod` path and dependency caching validation. |

## Notes

- Uses `actions/setup-go@v5` under the hood.
- Automatically enables caching for Go modules based on `go.sum` under the working directory.
