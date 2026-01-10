pipeline {
    agent any

    environment {
        DOCKER_USERNAME = 'kiransuresh12'
        DOCKER_CREDS = credentials('dockerhub-creds')
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
                    if (env.BRANCH_NAME == 'main' || env.GIT_BRANCH == 'origin/main') {
                        env.DEPLOY_ENV = 'prod'
                    } else {
                        env.DEPLOY_ENV = 'dev'
                    }
                }
                echo "Deploying to environment: ${env.DEPLOY_ENV}"
            }
        }

        stage('Docker Login') {
            steps {
                sh '''
                    echo "$DOCKER_CREDS_PSW" | docker login \
