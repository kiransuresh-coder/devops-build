pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('dockerhub-creds')
        DOCKER_USER = 'kiransuresh12'
        IMAGE_NAME = 'react-app'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  chmod +x build/build.sh
                  cd build
                  ./build.sh dev
                '''
            }
        }

        stage('Docker Login') {
            steps {
                sh '''
                  echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin
                '''
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                  docker tag react-app:latest kiransuresh12/react-app-dev:latest
                  docker push kiransuresh12/react-app-dev:latest
                '''
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
