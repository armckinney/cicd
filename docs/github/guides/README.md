# GitHub CI/CD Guides

Welcome to the use-case driven documentation guides for GitHub Actions and Reusable Workflows in this repository.

Unlike the individual API / reference documentations, these guides show you how to compose multiple actions and reusable workflows to address concrete DevOps scenarios and implement end-to-end pipelines.

---

## 🗂️ Available Guides

Browse the guides below based on your target stack or deployment use case:

### 🐳 Container & Runtime Orchestration
* **[Pipeline Runtime Guide](./pipeline-runtime.md)**: Design and build a unified, hermetic container environment to run all your test, lint, and deploy jobs sandboxed.
* **[Container Build Pipelines](./container-build.md)**: Set up production container image compilation, multi-registry pushes, build caching, and tag-overwrite checks.

### 🛠️ Infrastructure as Code (IaC)
* **[Terraform CI/CD Pipeline](./terraform-pipeline.md)**: Implement a secure, state-managed, multi-stage Terraform workflow including formatting, validation, Trivy security scanning, plans, manual approval gates, and deployment.

### 🏷️ Semantic Versioning & Releases
* **[Version Resolution Guide](./version-resolution.md)**: Leverage the Verge tag provider to dynamically calculate next SemVer numbers based on commits or PR labels without hardcoding.
* **[Versioned Release Guide](./versioned-release.md)**: Automate tagging, pushing git tags, drafting releases with changelogs on GitHub, and pruning developer development tags.

### 🐍 Python Package & App Lifecycles
* **[Python Static Analysis](./python-static-analysis.md)**: Implement automated code quality checks, style guides (flake8, black, mypy), and pytest unit testing.
* **[Python Package Pipeline](./python-package-pipeline.md)**: Compile and publish source distributions (wheels and tarballs) to PyPI or corporate package repositories.

### 🐹 Go Applications & Binaries
* **[Go CI/CD Pipeline Guide](./go-pipeline.md)**: Set up automated quality assurance (golangci-lint, tests with race detection and coverage) and production binary builds published directly to GitHub Releases.

### 🤖 Automation & Pull Requests
* **[Pull Request Automation](./pr-automation.md)**: Automate background synchronization tasks, track drifitng files, commit changes, and open pre-formatted Pull Requests.

