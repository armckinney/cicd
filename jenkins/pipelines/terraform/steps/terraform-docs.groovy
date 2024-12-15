def call() {
    sh '''
        #todo: variable substitution
        # run terraform-docs using config file and compare validation to repository README
        cd terraform/configurations
        terraform-docs --output-file=TFDOCS_VALIDATION.md .
        cmp "${bamboo.configuration}/TFDOCS_VALIDATION.md" "${bamboo.configuration}/README.md"
    '''
}

return this;
