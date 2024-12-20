def call() {
    dockerBuild = load 'ci/steps/docker-build.groovy'
    dockerPush = load 'ci/steps/docker-push.groovy'

    dockerBuild()
    dockerPush()
}

return this;
