# lint

This document describes the local composite action to run **golangci-lint** on Go source code.

Action file: [../../../../.github/actions/go/lint/action.yaml](../../../../.github/actions/go/lint/action.yaml)

## Purpose

Runs static analysis and code style checks on Go code using `golangci-lint` to catch bugs, formatting issues, and enforce best practices.

## When To Use

Use this action in pull requests and CI flows to validate code quality before merging.

## Usage

```yaml
- name: Run Go Lint
  uses: ./.github/actions/go/lint
  with:
    working-directory: '.'
    golangci-lint-version: 'v1.60'
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `working-directory` | No | `.` | Directory where Go code is located. |
| `golangci-lint-version` | No | `v1.60` | Version of `golangci-lint` to use. |
| `args` | No | `--timeout=5m` | Arguments to pass to the `golangci-lint` CLI. |

## Notes

- Uses `golangci/golangci-lint-action@v6` which has built-in smart caching for linting artifacts.
- Relies on a `.golangci.yml` file if one is present in the repository, otherwise falls back to defaults.
