pipeline {
  agent none
  stages {
    stage ('Git Checkout') {
      agent any
      steps {
        git branch: 'master', credentialsId: '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', url: 'https://github.com/tahritakwa/commercial.git'
    }
  }
    stage('server') {
      agent any
      steps {
          sh 'docker build -t com_image .'
      }
    }
    stage('docker') {
      agent any
      steps {
          sh 'docker-compose up --build -d'
      }
    }

  }
}

