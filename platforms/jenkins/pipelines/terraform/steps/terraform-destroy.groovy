def call() {
    sh """
        terraform -chdir=terraform/configurations/${CONFIGURATION} apply -auto-approve -var-file=env/${ENVIRONMENT}.tfvars -destroy
    """
}

return this;
