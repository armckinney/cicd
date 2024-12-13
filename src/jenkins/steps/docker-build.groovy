def call(String dockerfilePath, String containerRegistryName, String repositoryName, String branchName) {
    sh '''
        # todo: variables substitution
        docker buildx build \
            --file ${dockerfilePath} \
            --tag ${containerRegistryName}/${repositoryName}:${branchName} \
            .  
    '''
}

return this;
