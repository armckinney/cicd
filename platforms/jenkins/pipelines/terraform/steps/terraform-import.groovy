def call() {
    sh """
        # unhide the imports file temporarily for import-specific task
        mv terraform/configurations/${CONFIGURATION}/.imports.tf terraform/configurations/${CONFIGURATION}/imports.tf

        terraform -chdir=terraform/configurations/${CONFIGURATION} refresh -var-file=env/${ENVIRONMENT}.tfvars

        mv terraform/configurations/${CONFIGURATION}/imports.tf terraform/configurations/${CONFIGURATION}/.imports.tf
    """
}

return this;
