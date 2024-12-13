def call(Map pipelineParams) {
    pipeline {
        agent {
            docker {
                image 'ubuntu:20.04'
                // args '-v /var/run/docker.sock:/var/run/docker.sock'
            }
        }
        stages {
            stage('test') {
                parallel {
                    stage('test-1') {
                        steps {
                            script {
                                testStage = load 'ci/stages/stage.groovy'
                                testStage(pipelineParams.configuration)
                            }
                        }
                    }
                    stage('test-2') {
                        steps {
                            script {
                                testStage = load 'ci/stages/stage.groovy'
                                testStage(pipelineParams.configuration)
                            }
                        }
                    }
                }
            }

            // stage('container-build') {
            //     agent {
            //         docker {
            //             image 'docker:19.03.12'
            //             args '-v /var/run/docker.sock:/var/run/docker.sock'
            //         }
            //     }
            //     steps {
            //         script {
            //             containerBuild = load 'ci/stages/container-build.groovy'
            //             containerBuild()
            //         }
            //     }
            // }

            // stage('static-analysis') {
            //     parallel{
            //         stage('terraform-validate') {
            //             steps {
            //                 script {
            //                     terraformValidate = load 'ci/stages/terraform-validate.groovy'
            //                     terraformValidate()
            //                 }
            //             }
            //         }
            //         stage('terraform-format') {
            //             steps {
            //                 script {
            //                     terraformFormat = load 'ci/stages/terraform-format.groovy'
            //                     terraformFormat()
            //                 }
            //             }
            //         }
            //         stage('terraform-lint') {
            //             steps {
            //                 script {
            //                     terraformLint = load 'ci/stages/terraform-lint.groovy'
            //                     terraformLint()
            //                 }
            //             }
            //         }
            //         stage('terraform-docs') {
            //             steps {
            //                 script {
            //                     terraformDocs = load 'ci/stages/terraform-docs.groovy'
            //                     terraformDocs()
            //                 }
            //             }
            //         }
            //         stage('terraform-security') {
            //             steps {
            //                 script {
            //                     terraformSecurity = load 'ci/stages/terraform-security.groovy'
            //                     terraformSecurity()
            //                 }
            //             }
            //         }
            //     }
            // }
        }

        post {
            always {
                notifyBitbucket commitSha1: params.refChange_toHash
            }
            cleanup {
                cleanWs()
            }
        }

        options {
            timestamps()
            timeout(time: 30, unit: 'MINUTES')
        }

        triggers {
            GenericTrigger(
                causeString: 'Generic Cause',
                genericVariables: [
                    [key: 'refChange_name', value: '$.push.changes[0].new.name'],
                    [key: 'refChange_toHash', value: '$.push.changes[0].new.target.hash']
                ],
                genericRequestVariables: [
                    [key: 'baseUrl', regexpFilter: '']
                ],
                printContributedVariables: true,
                printPostContent: true,
                regexpFilterExpression: '',
                regexpFilterText: '',
                token: pipelineParams.pipelineToken
            )
        }
    }
}