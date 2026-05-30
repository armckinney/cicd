# Go CI/CD Pipeline Guide

This guide describes how to implement an end-to-end automated quality control, testing, and deployment (release publishing) pipeline for Go applications using reusable GitHub workflows. It also incorporates dynamic semantic version resolution using the **Verge CLI** and offers options for both simple builds and professional multi-platform packaging via **GoReleaser**.

## Use Case

Go is natively compiled, making static analysis (linting), unit testing, and binary compilation key parts of the CI/CD lifecycle. An automated Go pipeline should:
1. **Lint and Check**: Use static analysis tools like `golangci-lint` to detect potential bugs, style issues, and performance bottlenecks.
2. **Unit Test**: Run tests with Go's built-in toolchain, checking for race conditions and measuring coverage.
3. **Resolve Version**: Dynamically calculate the next Semantic Version (SemVer) based on commit history or pull request context without manual intervention.
4. **Deploy & Publish**: Compile optimized binaries and publish them as release assets on GitHub under the dynamically calculated version.

---

## Go CI/CD End-to-End Workflow (Simple Build)

Below is a complete recipe combining Go reusable workflows and Verge tagging into a single pipeline.
*   **On Pull Request**: Runs linting and unit tests in parallel.
*   **On Push to Main**: Runs linting and tests, dynamically calculates the next SemVer using the Verge tag provider, builds the optimized Go binaries, and publishes them to a new GitHub Release.

```yaml
name: Go CI/CD Pipeline

on:
  pull_request:
    branches: [ main ]
    paths: [ '**.go', 'go.mod', 'go.sum' ]
  push:
    branches: [ main ]

permissions:
  contents: write
  pull-requests: read

jobs:
  # Stage 1: Static Analysis
  go-static-analysis:
    uses: ./.github/workflows/rwf-go-static-analysis.yaml
    with:
      working_directory: '.'
      go_version: '1.22'

  # Stage 2: Unit Testing (runs in parallel with static analysis)
  go-test:
    uses: ./.github/workflows/rwf-go-test.yaml
    with:
      working_directory: '.'
      go_version: '1.22'
      race: true
      coverage: true

  # Stage 3: Resolve Version & Tag (only runs on push to main after CI passes)
  resolve-version:
    needs: [ go-static-analysis, go-test ]
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'
    uses: ./.github/workflows/rwf-verge-tag.yaml
    with:
      prune_dev_tags: true

  # Stage 4: Build & Publish (compiles binary and publishes it to the release)
  go-build-deploy:
    needs: [ resolve-version ]
    uses: ./.github/workflows/rwf-go-build-and-publish.yaml
    with:
      working_directory: '.'
      go_version: '1.22'
      packages: './cmd/myapp'
      output: 'myapp-linux-amd64'
      flags: '-ldflags="-s -w"' # Strip debugging symbols for smaller binaries
      publish_tag: ${{ needs.resolve-version.outputs.version }}
```

---

## Alternative CD: Professional Multi-Platform Releases via GoReleaser

For mature open-source tools or production systems requiring multi-platform compilation (Windows, macOS, Linux, ARM/AMD64), package archives (tar.gz/zip), checksum generation, and structured changelogs, we recommend **GoReleaser**.

Here is the CD recipe substituting the simple build-and-publish stage with our reusable GoReleaser workflow:

```yaml
name: Go CI/CD Pipeline with GoReleaser

on:
  pull_request:
    branches: [ main ]
    paths: [ '**.go', 'go.mod', 'go.sum' ]
  push:
    branches: [ main ]

permissions:
  contents: write
  pull-requests: read

jobs:
  # Stage 1: Static Analysis
  go-static-analysis:
    uses: ./.github/workflows/rwf-go-static-analysis.yaml
    with:
      working_directory: '.'
      go_version: '1.22'

  # Stage 2: Unit Testing
  go-test:
    uses: ./.github/workflows/rwf-go-test.yaml
    with:
      working_directory: '.'
      go_version: '1.22'
      race: true
      coverage: true

  # Stage 3: Resolve Version & Tag (runs on push to main)
  # GoReleaser operates on the git tag created in this step!
  resolve-version:
    needs: [ go-static-analysis, go-test ]
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'
    uses: ./.github/workflows/rwf-verge-tag.yaml
    with:
      prune_dev_tags: true

  # Stage 4: Professional Release via GoReleaser
  go-releaser-deploy:
    needs: [ resolve-version ]
    uses: ./.github/workflows/rwf-go-releaser.yaml
    with:
      working_directory: '.'
      go_version: '1.22'
      goreleaser_version: 'latest'
      args: 'release --clean'
    secrets:
      token: ${{ secrets.GITHUB_TOKEN }}
```

### GoReleaser Configuration File Setup

To use GoReleaser, you must create a configuration file named `.goreleaser.yaml` in the root of your Go project. Below is an example configuration modeled after the `verge` repository:

```yaml
version: 2
project_name: myapp
builds:
  - id: myapp
    main: ./cmd/myapp
    binary: myapp
    env:
      - CGO_ENABLED=0
    goos:
      - darwin
      - linux
      - windows
    goarch:
      - amd64
      - arm64
    ldflags:
      - -s -w
      - -X main.Version={{.Version}}
      - -X main.Commit={{.Commit}}
      - -X main.Date={{.Date}}
archives:
  - format: tar.gz
    name_template: "{{.ProjectName}}_{{.Version}}_{{.Os}}_{{.Arch}}"
checksum:
  name_template: checksums.txt
  algorithm: sha256
```

---

## How the Components Work

### 1. Static Analysis (`rwf-go-static-analysis.yaml`)
This workflow calls the custom Go `setup` and `lint` actions:
- Sets up Go using `actions/setup-go` with caching enabled.
- Runs `golangci-lint` which runs multiple standard linters concurrently (`errcheck`, `gosimple`, `govet`, `staticcheck`, etc.).
- Auto-caches linter dependencies and execution state for fast subsequent runs.

### 2. Unit Testing (`rwf-go-test.yaml`)
This workflow runs the package test suite:
- Validates code execution and catches memory errors using the `-race` detector flag.
- Generates code coverage metrics (`coverage.out`) that can be exported or validated against a code quality gate.

### 3. Version Resolution (`rwf-verge-tag.yaml`)
Kept isolated as its own reusable stage, the Verge tagging workflow:
- Connects to the repository and calculates the next logical release version.
- Automatically generates and pushes the git tags.
- Cleans up ephemeral developer pre-release tags once the final version is tagged.
- Publishes the final tag name as an output parameter (`version`).

### 4. Build & Publish (`rwf-go-build-and-publish.yaml`)
This workflow compiles your application and publishes it:
- Uses `go build` with specified target files/packages, output naming, and linker flags (like `-ldflags="-s -w"` to produce highly optimized, stripped binaries).
- Feeds the dynamically generated tag output from the `resolve-version` job (`${{ needs.resolve-version.outputs.version }}`) into the `publish_tag` input.
- Publishes the final binary to the specified GitHub Release tag via `softprops/action-gh-release@v2`.

### 5. Professional Release (`rwf-go-releaser.yaml`)
This workflow utilizes GoReleaser:
- Performs a checkout with `fetch-depth: 0` to retrieve all historical tags, which GoReleaser requires to construct the release changelog and identify the tag.
- Sets up Go and runs GoReleaser using the local `go/releaser` action.
- Generates multi-architecture binaries and tarballs, creates a GitHub Release, writes a formatted changelog, and uploads checksums.

---

## Notes & Best Practices

- **Go Version Matching**: Omit `go_version` to let the workflow automatically parse the required version directly from the project's `go.mod` file.
- **Authentication**: Ensure the GITHUB_TOKEN has write permission for contents (`contents: write`) in order to let Verge push git tags and allow the release steps (both GoReleaser and GitHub Release) to publish assets.
- **Workflow Isolation**: Keeping Verge versioning as an isolated job in the workflow ensures that we only incur the compile and deployment overhead after a new official tag is successfully minted.
