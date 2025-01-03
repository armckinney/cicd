def call() {
    sh """
        trivy config --tf-exclude-downloaded-modules --severity HIGH,CRITICAL --exit-code 1 terraform/configurations/${CONFIGURATION}
    """
}

return this;
