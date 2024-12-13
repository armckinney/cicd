def call() {
    sh '''
        #todo: variable substitution
        terraform -chdir=terraform/configurations/${bamboo.configuration} init -backend-config=env/${bamboo.environment}.tfbackend -reconfigure
    '''
}

return this;
