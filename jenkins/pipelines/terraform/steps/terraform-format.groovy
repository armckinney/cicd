def call() {
    sh '''
        #todo: variable substitution
        terraform -chdir=terraform/configurations/${bamboo.configuration} fmt -check 
    '''
}

return this;
