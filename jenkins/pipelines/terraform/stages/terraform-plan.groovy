def call() {
    configureAwsAuth = load 'ci/steps/configure-aws-auth.groovy'
    terraformInit = load 'ci/steps/terraform-init.groovy'
    terraformImport = load 'ci/steps/terraform-import.groovy'
    terraformPlan = load 'ci/steps/terraform-plan.groovy'

    configureAwsAuth()
    terraformInit()
    terraformImport()
    terraformPlan()
}

return this;
