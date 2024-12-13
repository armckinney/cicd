def call(String artifactoryPassword, String ArtifactoryUser, String containerRegistryName, String containerRegistryServer, String repositoryName, String branchName) {
    sh '''
        # todo: varible substitution
        echo ${artifactoryPassword} | docker login --username ${artifactoryUser} --password-stdin ${containerRegistryServer}
        docker push ${containerRegistryName}/${repositoryName}:${branchName} 
    '''
}

return this;
