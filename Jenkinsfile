pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'kiransuresh12'
        IMAGE_NAME = 'react-app'
        ENV = "${env.BRANCH_NAME == 'main' ? 'prod' : 'dev'}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
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
                        ./build.sh $ENV
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    ./deploy.sh $ENV
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful for environment: $ENV"
        }
        failure {
            echo "❌ Pipeline failed"
        }
    }
}
