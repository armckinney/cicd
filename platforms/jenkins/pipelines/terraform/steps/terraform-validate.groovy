def call() {
    sh """
        terraform -chdir=terraform/configurations/${CONFIGURATION} init -backend=false
        terraform -chdir=terraform/configurations/${CONFIGURATION} validate
    """
}

return this;
