pipeline {
  agent any

  environment {
    DOCKERHUB = credentials('dockerhub-creds')
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
          ./build.sh
        '''
      }
    }

    stage('Push to DockerHub') {
      steps {
        script {
          def branch = env.GIT_BRANCH?.replaceFirst(/^origin\\//, '')

          sh """
            echo ${DOCKERHUB_PSW} | docker login -u ${DOCKERHUB_USR} --password-stdin
          """

          if (branch == 'dev') {
            sh """
              docker tag ${IMAGE_NAME}:latest kiransuresh12/dev:latest
              docker push kiransuresh12/dev:latest
            """
          } else if (branch == 'main') {
            sh """
              docker tag ${IMAGE_NAME}:latest kiransuresh12/prod:latest
              docker push kiransuresh12/prod:latest
            """
          } else {
            echo "Branch ${branch} not handled"
          }
        }
      }
    }

    stage('Deploy') {
      steps {
        script {
          def branch = env.GIT_BRANCH?.replaceFirst(/^origin\\//, '')

          if (branch == 'dev') {
            sh '''
              chmod +x build/deploy.sh
              cd build
              ./deploy.sh dev
            '''
          } else if (branch == 'main') {
            sh '''
              chmod +x build/deploy.sh
              cd build
              ./deploy.sh prod
            '''
          } else {
            echo "Branch ${branch} not handled"
          }
        }
      }
    }
  }

  post {
    success {
      echo "Pipeline completed successfully"
    }
    failure {
      echo "Pipeline failed"
    }
  }
}
