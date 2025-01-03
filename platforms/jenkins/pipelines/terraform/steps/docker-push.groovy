def call()
   sh '''
        echo ${CONTAINER_REGISTRY_CREDENTIALS_PSW} | docker login --username ${CONTAINER_REGISTRY_CREDENTIALS_USR} --password-stdin ${CONTAINER_REGISTRY_SERVER}
        docker push ${CONTAINER_REGISTRY_NAME}/${REPOSITORY_NAME}:${BRANCH_NAME} 
    '''
}

return this;
