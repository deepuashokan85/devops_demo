pipeline {

  agent any
  
    parameters {

        choice(choices: ['aws','gcp'], description: '', name: 'cloud')
        choice(choices: ['apply','destroy'], description: '', name: 'trigger')
        string(name: 'instance', defaultValue: '0', description: 'instance count')
        }


    stages {

            stage("Terraform AWS Provision") {
            when {
                expression { params.cloud == 'aws' }
                expression { params.trigger == 'apply' }
                }
             steps{

                   sh script: "cd terraform; /usr/local/bin/terraform init; /usr/local/bin/terraform plan; /usr/local/bin/terraform apply -auto-approve"
               }
            }
            stage("Terraform GCP Provision") {
            when {
                expression { params.cloud == 'gcp' }
                expression { params.trigger == 'apply' }
                }
             steps{
                   sh script: "cd rhel; /usr/local/bin/terraform init; /usr/local/bin/terraform plan; /usr/local/bin/terraform apply -auto-approve"
               }
            }

            stage("Terraform AWS Destroy") {
            when {
                expression { params.cloud == 'aws' }
                expression { params.trigger == 'destroy' }
                }
             steps{
                   sh script: "cd centos;  /usr/local/bin/terraform init; /usr/local/bin/terraform  destroy -auto-approve"
               }
            }
            stage("Terraform GCP Destroy") {
            when {
                expression { params.cloud == 'gcp' }
                expression { params.trigger == 'destroy' }
                }
             steps{
                   sh script: "cd rhel; /usr/local/bin/terraform init; /usr/local/bin/terraform  destroy -auto-approve"
               }
            }

      }
    }
