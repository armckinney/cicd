def call() {
    sh """
        terraform -chdir=terraform/configurations/${CONFIGURATION} fmt -check 
    """
}

return this;
