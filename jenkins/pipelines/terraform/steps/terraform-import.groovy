def call() {
    sh '''
        #todo: variable substitution
        # unhide the imports file temporarily for import-specific task
        mv terraform/configurations/${bamboo.configuration}/.imports.tf terraform/configurations/${bamboo.configuration}/imports.tf

        terraform -chdir=terraform/configurations/${bamboo.configuration} refresh -var-file=env/${bamboo.environment}.tfvars

        mv terraform/configurations/${bamboo.configuration}/imports.tf terraform/configurations/${bamboo.configuration}/.imports.tf
    '''
}

return this;
