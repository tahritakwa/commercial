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

