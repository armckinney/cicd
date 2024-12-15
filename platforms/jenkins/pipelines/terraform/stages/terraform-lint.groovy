def call() {
    terraformLint = load 'ci/steps/terraform-lint.groovy'
    terraformLint()
}

return this;
