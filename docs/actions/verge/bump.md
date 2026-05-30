# bump

This document describes the local composite action to calculate and parse next semantic versions using the **Verge CLI**.

Action file: [../../../.github/actions/verge/bump/action.yaml](../../../.github/actions/verge/bump/action.yaml)

## Purpose

Installs the Verge CLI, calculates the next version tag, and parses version attributes (e.g. prerelease status, cleanup pattern prefixes) in a single modular step.

## When To Use

Use this action inside a version-tagging workflow to automate Verge installation and execute the bump and parse commands without writing shell script configurations inside the workflow.

## Usage

```yaml
- name: Verge bump
  id: verge_bump
  uses: ./.github/actions/verge/bump
  with:
    verge_arguments: --kind final
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `verge_arguments` | No | empty string | Raw arguments and flags passed directly to the `verge bump` command (e.g., `--kind final`). |

## Outputs

| Name | Description |
| --- | --- |
| `tag` | The calculated next version tag (e.g. `v1.2.3` or `v1.2.3-dev.1`). |
| `is_prerelease` | `"true"` if the calculated tag is a prerelease version, `"false"` otherwise. |
| `prerelease_prefix` | The computed prerelease tag pattern prefix for tag cleanup (e.g. `v1.2.3-dev`). |

## Notes

- Automatically downloads and installs the latest Verge CLI release.
- Executes `verge parse` internally to populate version metadata outputs.
