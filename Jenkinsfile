pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'kiransuresh12'
        IMAGE_NAME = 'react-app'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Set Environment') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        env.DEPLOY_ENV = 'prod'
                    } else {
                        env.DEPLOY_ENV = 'dev'
                    }
                }
                echo "Deploying to environment: ${env.DEPLOY_ENV}"
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        chmod +x build.sh deploy.sh
                        ./build.sh $DEPLOY_ENV
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    ./deploy.sh $DEPLOY_ENV
                '''
            }
        }
    }
}
