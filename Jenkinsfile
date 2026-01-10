pipeline {
    agent any

    environment {
        // Must match the Jenkins credentials ID exactly
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
                    // Determine branch and environment
                    def branch = env.BRANCH_NAME ?: env.GIT_BRANCH.replace('origin/', '')
                    def envArg
                    if (branch == 'dev') {
                        envArg = 'dev'
                    } else if (branch == 'main') {
                        envArg = 'prod'
                    } else {
                        error "Branch not supported: ${branch}"
                    }

                    // Build the Docker image using build.sh
                    sh """
                        chmod +x build/build.sh
                        cd build
                        ./build.sh ${envArg}
                    """
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Determine branch/environment again
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

                    // Push the image
                    sh "docker push ${DOCKER_USER}/react-app-${envArg}:latest"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Determine branch/environment again
                    def branch = env.BRANCH_NAME ?: env.GIT_BRANCH.replace('origin/', '')
                    def envArg
                    if (branch == 'dev') {
                        envArg = 'dev'
                    } else if (branch == 'main') {
                        envArg = 'prod'
                    } else {
                        error "Branch not supported: ${branch}"
                    }

                    // Run deploy.sh
                    sh """
                        chmod +x build/deploy.sh
                        cd build
                        ./deploy.sh ${envArg}
                    """
                }
            }
        }
    }
}
