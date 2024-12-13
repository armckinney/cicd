def call() {
    sh '''
        #todo: variable substitution
       terraform -chdir=terraform/configurations/${bamboo.configuration} init -backend=false
      terraform -chdir=terraform/configurations/${bamboo.configuration} validate
    '''
}

return this;
