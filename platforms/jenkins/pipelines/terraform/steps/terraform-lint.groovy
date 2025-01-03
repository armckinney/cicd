def call() {
    sh """
        tflint --chdir=terraform/configurations/${CONFIGURATION} --minimum-failure-severity=error --var-file=env/${ENVIRONMENT}.tfvars
    """
}

return this;
