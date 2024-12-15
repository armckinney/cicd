def call() {
    sh '''
        #todo: variable substitution
        trivy config --tf-exclude-downloaded-modules --severity HIGH,CRITICAL --exit-code 1 terraform/configurations/${bamboo.configuration}
    '''
}

return this;
