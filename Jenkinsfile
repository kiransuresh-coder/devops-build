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

        stage('Build & Push Docker Image') {
            steps {
                script {
                    def branch = env.BRANCH_NAME ?: env.GIT_BRANCH.replace('origin/', '')
                    def envArg
                    if (branch == 'dev') {
                        envArg = 'dev'
                    } else if (branch == 'main') {
                        envArg = 'prod'
                    } else {
                        error "Branch not supported: ${branch}"
                    }

                    // Login to Docker Hub
                    sh "echo \$DOCKERHUB_CREDS_PSW | docker login -u \$DOCKERHUB_CREDS_USR --password-stdin"

                    // Make scripts executable
                    sh "chmod +x build.sh deploy.sh"

                    // Run build.sh with proper environment
                    sh "./build.sh ${envArg}"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    def branch = env.BRANCH_NAME ?: env.GIT_BRANCH.replace('origin/', '')
                    def envArg
                    if (branch == 'dev') {
                        envArg = 'dev'
                    } else if (branch == 'main') {
                        envArg = 'prod'
                    } else {
                        error "Branch not supported: ${branch}"
                    }

                    sh "./deploy.sh ${envArg}"
                }
            }
        }
    }
}
