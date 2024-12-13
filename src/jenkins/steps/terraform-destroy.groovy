def call() {
    sh '''
        #todo: variable substitution
        terraform -chdir=terraform/configurations/${bamboo.configuration} apply -auto-approve -var-file=env/${bamboo.environment}.tfvars -destroy
    '''
}

return this;
