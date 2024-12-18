def call() {
    sh """
        terraform -chdir=terraform/configurations/${CONFIGURATION} show 
    """
}

return this;
