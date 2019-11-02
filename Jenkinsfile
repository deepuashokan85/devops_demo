pipeline {

  agent any

  stages {

    stage('terraform init') {
      steps {
        sh 'cd terraform; /usr/local/bin/terraform init'
      }
    }

    stage('terraform plan') {
       steps {
           sh 'echo test2'
         }
       }

    stage('terraform apply') {
      steps {
          sh 'echo test3'
        }
      }

    stage('terraform destroy') {
      steps {
          sh 'echo test4'
        }
      }
  }
}
