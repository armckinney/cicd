def call() {
    configureAwsAuth = load 'ci/steps/configure-aws-auth.groovy'
    terraformInit = load 'ci/steps/terraform-init.groovy'
    terraformShow = load 'ci/steps/terraform-show.groovy'

    configureAwsAuth()
    terraformInit()
    terraformShow()
}

return this;
