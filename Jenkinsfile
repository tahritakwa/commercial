pipeline {
  agent none
  stages {
    stage('dotnet Install') {
      agent {
        docker {
          image 'mcr.microsoft.com/dotnet/sdk:5.0'
        }
      }
      steps {
        script {
          sh 'dotnet restore'
        }
      }
      steps {
        script {
          sh 'dotnet publish -c Release -o out'
        }
      }
    }
    stage('server') {
      agent any
      steps {
        script {
          sh 'docker build image -t com_image .'
        }
      }
    }
    stage('docker') {
      agent any
      steps {
        script {
          sh 'docker-compose up --build -d'
        }
      }
    }

  }
}

