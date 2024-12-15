def call() {
    terraformDocs = load 'ci/steps/terraform-docs.groovy'
    terraformDocs()
}

return this;
