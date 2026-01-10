pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
        DOCKER_USER = 'kiransuresh12'
    }

    stages {

        stage('Build Docker Image') {
            steps {
                sh '''
                  chmod +x build/build.sh
                  cd build
                  ./build.sh
                '''
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
                    } 
                    else if (branch == 'main') {
                        sh '''
                          docker tag react-app:latest kiransuresh12/react-app-prod:latest
                          docker push kiransuresh12/react-app-prod:latest
                        '''
                    } 
                    else {
                        echo "Branch not supported: ${branch}"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    def branch = env.BRANCH_NAME ?: env.GIT_BRANCH.replace('origin/', '')

                    sh '''
                      chmod +x build/deploy.sh
                    '''

                    if (branch == 'dev') {
                        sh 'cd build && ./deploy.sh dev'
                    } 
                    else if (branch == 'main') {
                        sh 'cd build && ./deploy.sh prod'
                    }
                }
            }
        }
    }
}
