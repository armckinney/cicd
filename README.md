<!-- header -->
<div align="center">
    <p>
    <!-- Header -->
        <img width="100px" src="https://img.stackshare.io/stack/1425302/default_a6395e52777e7bc30ccc2e19fc576907db64f1ca.Default"  alt="cicd" />
        <h2>CICD Workflows</h2>
        <p><i>Extendible and Reusable CICD Workflows</i></p>
    </p>
    <p>
    <!-- Shields -->
        <a href="https://github.com/armckinney/cicd/LICENSE.txt">
            <img alt="License" src="https://img.shields.io/github/license/armckinney/cicd.svg" />
        </a>
        <a href="https://github.com/armckinney/cicd/actions">
            <img alt="Tests Passing" src="https://github.com/armckinney/cicd/workflows/wf-terraform-ci-example-dev/badge.svg" />
        </a>
        <a href="https://codecov.io/gh/armckinney/cicd">
            <img src="https://codecov.io/gh/armckinney/cicd/branch/master/graph/badge.svg" />
        </a>
        <a href="https://github.com/armckinney/cicd/issues">
            <img alt="Issues" src="https://img.shields.io/github/issues/armckinney/cicd" />
        </a>
        <a href="https://github.com/armckinney/cicd/pulls">
            <img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/armckinney/cicd" />
        </a>
    </p>
    <p>
    <!-- Links -->
        <a href="https://github.com/armckinney/cicd/issues/new/choose">Report Bug</a>
        ·
        <a href="https://github.com/armckinney/cicd/issues/new/choose">Request Feature</a>
    </p>
</div>
<br>
<br>



<!-- Description -->
**CICD Workflows** is a repository consisting of a robust collection of reusable and extendible Continuous Integration and Continuous Deployment automation tools, with a primary focus on **GitHub Actions** and **Reusable Workflows**. 

It provides modular, standardized, and DRY (Don't Repeat Yourself) components to automate your software development lifecycle and infrastructure provisioning (specifically optimized for Terraform and Python workflows).

---

## 📖 Usage Documentation

For detailed usage, inputs, secrets, and setup instructions, please refer to the following comprehensive documentation guides:

* **[GitHub CI/CD Guides](./docs/github/guides/README.md)**: Explore end-to-end, use-case driven guides for designing container runtimes, terraform pipelines, semantic versioning, and python packages.
* **[Reusable GitHub Workflows Documentation](./docs/github/reusable-workflows/README.md)**: Explore the pre-defined, parameterizable pipelines (prefixed with `rwf-`) for pull requests, manual approvals, builds, and terraform operations.
* **[Local GitHub Actions Documentation](./docs/github/actions/README.md)**: Review the granular, dry composite actions (such as `init`, `plan`, `apply`, `validate`, `setup`, `bump`) that power our workflows or can be integrated into custom pipelines.

---

### Supported Platforms

While this repository is optimized and primarily built for GitHub Actions, we also host copy-and-paste automation components for other platforms:

* **[GitHub Actions & Reusable Workflows](./platforms/github/)** (Primary Focus)
* [Bamboo Plans](./platforms/bamboo/)
* [Jenkins Pipelines](./platforms/jenkins/)

