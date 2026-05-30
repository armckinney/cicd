# build

This document describes the local composite action to **compile Go packages**.

Action file: [../../../../.github/actions/go/build/action.yaml](../../../../.github/actions/go/build/action.yaml)

## Purpose

Compiles Go packages and generates production binaries, supporting customized output files and build flags.

## When To Use

Use this action in build pipelines, pre-release pipelines, or CD pipelines to produce compiled binaries from your Go code.

## Usage

```yaml
- name: Build Go Binary
  uses: ./.github/actions/go/build
  with:
    working-directory: '.'
    packages: './cmd/myapp'
    output: 'myapp-binary'
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `working-directory` | No | `.` | Directory where Go code is located. |
| `packages` | No | `./...` | The Go packages or entrypoint file to compile. |
| `output` | No | empty string | The relative path/filename for the built output binary. |
| `flags` | No | empty string | Additional compiler flags to pass (e.g. `-ldflags="-s -w"`). |
