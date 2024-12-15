def call() {
    terraformSecurity = load 'ci/steps/terraform-security.groovy'
    terraformSecurity()
}

return this;
