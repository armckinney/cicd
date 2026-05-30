# test

This document describes the local composite action to run **Go unit tests**.

Action file: [../../../../.github/actions/go/test/action.yaml](../../../../.github/actions/go/test/action.yaml)

## Purpose

Runs unit and integration tests across Go packages with optional race detection and code coverage file generation.

## When To Use

Use this action during pull requests or push CI pipelines to guarantee functional correctness of Go applications.

## Usage

```yaml
- name: Run Go Tests
  uses: ./.github/actions/go/test
  with:
    working-directory: '.'
    race: 'true'
    coverage: 'true'
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `working-directory` | No | `.` | Directory where Go code is located. |
| `race` | No | `true` | Enable Go race detector (string `true` or `false`). |
| `coverage` | No | `true` | Enable code coverage profiling and output `coverage.out` (string `true` or `false`). |
| `packages` | No | `./...` | The Go packages to run tests on. |

## Notes

- Output coverage reports are saved as `coverage.out` inside the `working-directory` under atomic mode, perfect for uploading to Codecov or other coverage metrics trackers.
