def call() {
    terraformValidate = load 'ci/steps/terraform-validate.groovy'
    terraformValidate()
}

return this;
