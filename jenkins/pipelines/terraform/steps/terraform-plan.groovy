def call() {
    sh '''
        #todo: variable substitution
        terraform -chdir=terraform/configurations/${bamboo.configuration} plan -var-file=env/${bamboo.environment}.tfvars
    '''
}

return this;
