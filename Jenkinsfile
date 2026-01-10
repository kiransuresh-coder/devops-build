pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
        DOCKER_USER = 'kiransuresh12'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Determine branch/environment
                    def branch = env.BRANCH_NAME ?: env.GIT_BRANCH.replace('origin/', '')
                    def envArg
                    if (branch == 'dev') {
                        envArg = 'dev'
                    } else if (branch == 'main') {
                        envArg = 'prod'
                    } else {
                        error "Branch not supported: ${branch}"
                    }

                    // Build the Docker image
                    sh """
