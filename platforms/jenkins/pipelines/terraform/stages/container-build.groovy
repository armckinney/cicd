def call() {
    dockerBuildPush = load 'ci/steps/docker-build-push.groovy'
    dockerBuildPush()
}

return this;
