pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
        DOCKERHUB_USER  = 'kiransuresh12'
    }

    stages {

        stage('Build & Push Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {

                        sh '''
                          echo "Building DEV image"
                          echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin

                          chmod +x build/build.sh
                          cd build
                          ./build.sh dev
                        '''

                    } else if (env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'master') {

                        sh '''
                          echo "Building PROD image"
                          echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin

                          chmod +x build/build.sh
                          cd build
                          ./build.sh prod
                        '''

                    } else {
                        echo "Branch not handled: ${env.BRANCH_NAME}"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {

                        sh '''
                          echo "Deploying DEV environment"
                          chmod +x build/deploy.sh
                          cd build
                          ./deploy.sh dev
                        '''

                    } else if (env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'master') {

                        sh '''
                          echo "Deploying PROD environment"
                          chmod +x build/deploy.sh
                          cd build
                          ./deploy.sh prod
                        '''

                    }
                }
            }
        }
    }
}
