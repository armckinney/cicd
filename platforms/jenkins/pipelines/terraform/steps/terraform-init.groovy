def call() {
    sh """
        terraform -chdir=terraform/configurations/${CONFIGURATION} init -backend-config=env/${ENVIRONMENT}.tfbackend -reconfigure
    """
}

return this;
