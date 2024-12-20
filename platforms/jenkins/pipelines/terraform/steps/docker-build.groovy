def call(String dockerfilePath, String containerRegistryName, String repositoryName, String branchName) {
    sh '''
        docker buildx build \
            --file ${DOCKERFILE_PATH} \
            --tag ${CONTAINER_REGISTRY_NAME}/${REPOSITORY_NAME}:${BRANCH_NAME} \
            .  
    '''
}

return this;
