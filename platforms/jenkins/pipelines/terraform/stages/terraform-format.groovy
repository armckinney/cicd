def call() {
    terraformFormat = load 'ci/steps/terraform-format.groovy'
    terraformFormat()
}

return this;
