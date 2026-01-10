pipeline {
    agent any

    environment {
        DOCKER_USER = 'kiransuresh12'
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
                        env.ENVIRONMENT = 'prod'
                    } else {
                        env.ENVIRONMENT = 'dev'
                    }
                }
                echo "Deploying to environment: ${ENVIRONMENT}"
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-creds', variable: 'DOCKER_PASS')]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u ${DOCKER_USER} --password-stdin
                    chmod +x build.sh deploy.sh
                    ./build.sh ${ENVIRONMENT}
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                ./deploy.sh ${ENVIRONMENT}
                '''
            }
        }
    }
}
