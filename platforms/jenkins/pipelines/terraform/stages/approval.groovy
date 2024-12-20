def call() {
    approval = load 'ci/steps/approval.groovy'
    approval()
}

return this;
