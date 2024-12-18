def call() {
    sh """
        terraform -chdir=terraform/configurations/${CONFIGURATION} plan -var-file=env/${ENVIRONMENT}.tfvars
    """
}

return this;
