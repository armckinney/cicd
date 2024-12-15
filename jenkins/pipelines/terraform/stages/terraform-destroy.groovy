def call() {
    configureAwsAuth = load 'ci/steps/configure-aws-auth.groovy'
    terraformInit = load 'ci/steps/terraform-init.groovy'
    terraformDestroy = load 'ci/steps/terraform-destroy.groovy'

    configureAwsAuth()
    terraformInit()
    terraformDestroy()
}

return this;
