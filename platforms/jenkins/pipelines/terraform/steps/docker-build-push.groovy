def call() {
    withDockerRegistry([url: "https://${env.CONTAINER_REGISTRY_SERVER}", credentialsId: env.CONTAINER_REGISTRY_CREDENTIALS_ID]) {
        containerImageBuildPush(
            env.DOCKERFILE_PATH, 
            ["${env.CONTAINER_REGISTRY_NAME}/${env.REPOSITORY_NAME}:${env.BRANCH_NAME}"] 
        )
    }
}

return this;
