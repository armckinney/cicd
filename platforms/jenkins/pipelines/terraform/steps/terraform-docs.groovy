def call() {
    sh """
        # run terraform-docs using config file and compare validation to repository README
        cd terraform/configurations
        terraform-docs --output-file=TFDOCS_VALIDATION.md .
        cmp "${CONFIGURATION}/TFDOCS_VALIDATION.md" "${CONFIGURATION}/README.md"
    """
}

return this;
