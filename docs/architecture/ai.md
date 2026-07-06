# Architecture Blueprint: Replicating AI Developer Environments

This document details the architecture, design choices, and directory-mapping specifications for standardizing local AI developer environments using **Dev Container Features**. It is a self-contained replication guide that can be copied directly into other repositories to instruct agents on setting up this unified agent rules and skills architecture.

---

## 1. Directory Layout

To align with our agent context model, a consuming repository must maintain the following file and folder layout:

```text
/ (Workspace Root)
├── .devcontainer/
│   └── devcontainer.json      # Dev container feature configuration
│
├── docs/
│   ├── architecture/
│   │   └── ai.md               # This blueprint
│   │
│   ├── architecture-design-records/  # ADR index and documents
│   │   ├── adr-001-use-architecture-design-records.md
│   │   └── ...
│   │
│   └── agents/
│       ├── AGENTS.md           # Global rules and entry point
│       │
│       ├── context/            # Path-scoped context files
│       │   ├── docker-build.instructions.md
│       │   └── ...
│       │
│       └── skills/             # Modular task-specific skill folders
│           ├── agent-skills/
│           │   └── SKILL.md    # Guide for writing skills
│           └── create-adr/
│               └── SKILL.md    # Tool/Shortcut to create new ADRs
```

---

## 2. Dev Container Feature Integration

AI mapping is automated at container startup using feature configurations. In your new repository's `.devcontainer/devcontainer.json`, declare:

```json
{
  "name": "My Workspace",
  "features": {
    "https://github.com/armckinney/containers/releases/download/<VERSION>/devcontainer-feature-copilot.tgz": {
      "rulefilePath": "docs/agents/AGENTS.md",
      "contextPath": "docs/agents/context",
      "skillsPath": "docs/agents/skills"
    },
    "https://github.com/armckinney/containers/releases/download/<VERSION>/devcontainer-feature-antigravity.tgz": {
      "rulefilePath": "docs/agents/AGENTS.md",
      "contextPath": "docs/agents/context",
      "skillsPath": "docs/agents/skills"
    }
  }
}
```

### Option Reference:
* `rulefilePath`: Path to the central global rules file. Default is `docs/agents/AGENTS.md`.
* `contextPath`: Path to the path-scoped instructions directory. Default is `docs/agents/context`.
* `skillsPath`: Path to the modular skills directory. Default is `docs/agents/skills`.
* *Note: Any of these settings can be set to `"none"`, `"false"`, or `""` (empty string) to disable that specific mapping.*

---

## 3. Copy-Paste Baseline Templates

To scaffold a new repository, copy and paste the following files directly into your workspace.

### Template A: Global Rules (`docs/agents/AGENTS.md`)
```markdown
# Agent Configuration

This document serves as the central index and entry point for AI agents working in this repository.

## Instructions Source

**All agents should reference the instruction files in `docs/agents/context/` before making changes.**

## System Message

You are working with this repository. Always reference the instruction files under `docs/agents/context/` and execute specific task templates under `docs/agents/skills/` where applicable.

## Key Principles

1. **Instructions First**: Check matching path-scoped instructions before changing code.
2. **ADR Alignment**: Consult ADRs in `docs/architecture-design-records/` before making architectural changes.
3. **Write ADRs**: Document all significant design choices as new ADRs using the `/create-adr` skill.
```

---

### Template B: Path-Scoped Context File (`docs/agents/context/docker-build.instructions.md`)
Path-scoped files use YAML frontmatter with `applyTo` globs. Copilot loads them automatically only when you edit matching files.

```markdown
---
name: Docker Build
description: Guidelines and commands for building Docker images.
applyTo:
  - "containers/**"
  - "Dockerfile"
  - "Dockerfile.dev"
---

# Docker Build Instructions

- Always use the current directory (`.`) as build context.
- Set container build timeouts to 60+ minutes.
- Verify Docker daemon connectivity: `docker ps`.
```

---

### Template C: Skill Standard (`docs/agents/skills/agent-skills/SKILL.md`)
Defines the standard format for modular, executable skills.

```markdown
---
name: Agent Skills
description: Rules and guidelines for creating and structuring reusable agent skills in this repository.
applyTo:
  - docs/agents/skills/**
---

# Agent Skills Standard

All instruction files are structured as modular **skills** to ensure reusability, isolation, and tooling compatibility.

## Structure

Each skill must live in a dedicated subfolder under `docs/agents/skills/` and have a `SKILL.md` entry point:

```text
docs/agents/skills/<skill-name>/
└── SKILL.md
```

## Writing `SKILL.md`

Every `SKILL.md` file must adhere to these guidelines:
1. **YAML Frontmatter**: Start the file with a YAML frontmatter block containing metadata:
   ```yaml
   ---
   name: Skill Name
   description: 1-2 sentence summary of when and why this skill is active.
   applyTo:
     - path/to/target/**
   ---
   ```
   * `name`: The human-readable name of the skill.
   * `description`: The purpose of this skill.
   * `applyTo`: YAML list of glob patterns mapping this skill to specific workspace paths for Copilot. Use `**` for repository-wide.
2. **Markdown formatting**: Use standard Markdown format for headings, bullet points, and code samples.
```

---

### Template D: ADR Skill (`docs/agents/skills/create-adr/SKILL.md`)
Exposes a command shortcut to generate new ADRs following standard naming and structure.

```markdown
---
name: create-adr
description: Template and instructions to create a new Architecture Design Record (ADR) in the repository.
applyTo:
  - docs/architecture-design-records/**
---

# Create ADR

Use this skill when you need to document a new architectural or design decision. It provides the required template and naming standards.

## Location & Naming

* **Directory**: `docs/architecture-design-records/`
* **Filename**: `adr-00X-name-of-decision.md` (e.g., `adr-001-use-architecture-design-records.md`)
  * Use 3-digit zero-padded numbers for `00X`.
  * Use lowercase kebab-case for the name.

## ADR Template

Use this Markdown skeleton for the file:

```markdown
# ADR 00X: Title of Decision

* **Status**: Proposed
* **Date**: YYYY-MM-DD
* **Author**: [Name/Agent]

## Context

Describe the background, the problem we are trying to solve, and the forces/constraints at play.

## Decision

State the decision clearly, including chosen options, technical choices, and the specific rationale for why this option was preferred.

## Consequences

Detail the impact of this decision (both positive and negative):
* What becomes easier?
* What becomes harder or requires extra work?
* What are the trade-offs?
```
```

---

### Template E: First ADR (`docs/architecture-design-records/adr-001-use-architecture-design-records.md`)
Saves a baseline ADR documenting the decision to adopt ADRs in the repository.

```markdown
# ADR 001: Use Architecture Design Records

* **Status**: Accepted
* **Date**: 2026-07-06
* **Author**: Agent

## Context

As this repository hosts setups that evolve over time, it is vital to track the design choices, constraints, and trade-offs made during development. Without a record of these decisions, it is difficult for human maintainers and autonomous AI agents to understand the historical context, leading to potential regression, confusion, or duplicate work when refactoring.

## Decision

We will adopt Architecture Design Records (ADRs) to document all major repository design and structure decisions. 
* All ADRs will be stored in `docs/architecture-design-records/`.
* ADRs will follow a sequential numbering scheme (`adr-001-name.md`, `adr-002-name.md`, etc.).
* Every record will follow a standard structure detailing Context, Decision, and Consequences.
* Autonomous AI agents are required to consult existing ADRs and write new ADRs when proposing structural changes.

## Consequences

* **Positive**:
  * Historical design context is preserved directly in the codebase.
  * AI agents can query this directory to quickly align with established architectural patterns.
  * Clear accountability and timeline of technical choices.
* **Neutral/Negative**:
  * Slight overhead to draft and review ADRs during pull requests/refactoring.
```
