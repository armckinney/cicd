def call() {
    sh '''
        #todo: variable substitution
        tflint --chdir=terraform/configurations/${bamboo.configuration} --minimum-failure-severity=error --var-file=env/${bamboo.environment}.tfvars
    '''
}

return this;
