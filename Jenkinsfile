pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
        DOCKER_USER = 'kiransuresh12'
        IMAGE_NAME = 'react-app'
    }

    stages {

        stage('Build Docker Image') {
            steps {
                script {
                    def branch = env.BRANCH_NAME ?: env.GIT_BRANCH.replace('origin/', '')

                    sh 'chmod +x build/build.sh'

                    if (branch == 'dev') {
                        sh 'cd build && ./build.sh dev'
                    } else if (branch == 'main') {
                        sh 'cd build && ./build.sh prod'
                    } else {
                        error "Unsupported branch: ${branch}"
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    def branch = env.BRANCH_NAME ?: env.GIT_BRANCH.replace('origin/', '')

                    sh '''
                      echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
                    '''

                    if (branch == 'dev') {
                        sh '''
                          docker tag react-app:latest kiransuresh12/react-app-dev:latest
                          docker push kiransuresh12/react-app-dev:latest
                        '''
                    } else if (branch == 'main') {
                        sh '''
                          docker tag react-app:latest kiransuresh12/react-app-prod:latest
                          docker push kiransuresh12/react-app-prod:latest
                        '''
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    def branch = env.BRANCH_NAME ?: env.GIT_BRANCH.replace('origin/', '')

                    sh 'chmod +x build/deploy.sh'

                    if (branch == 'dev') {
                        sh 'cd build && ./deploy.sh dev'
                    } else if (branch == 'main') {
                        sh 'cd build && ./deploy.sh prod'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}
``
