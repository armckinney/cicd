def call() {
    configureAwsAuth = load 'ci/steps/configure-aws-auth.groovy'
    terraformInit = load 'ci/steps/terraform-init.groovy'
    terraformApply = load 'ci/steps/terraform-apply.groovy'

    configureAwsAuth()
    terraformInit()
    terraformApply()
}

return this;
