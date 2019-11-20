pipeline {

  agent any
  
    parameters {

        choice(choices: ['aws','gcp'], description: '', name: 'cloud')
        choice(choices: ['apply','destroy'], description: '', name: 'trigger')
        string(name: 'AWS_ACCESS_KEY_ID', defaultValue: '', description: 'Access Key')
        password(name: 'AWS_SECRET_ACCESS_KEY', description: 'Encryption key')
        string(name: 'inst_count', defaultValue: '0', description: 'Instance Count')
        
        }

    stages {

            stage("Terraform AWS Provision") {
            when {
                expression { params.cloud == 'aws' }
                expression { params.trigger == 'apply' }
                }
             steps{
                   sh script: "/usr/local/bin/consul-template -template "terraform/terraform.tfvars.tmpl:terraform/terraform.tfvars" -once
                   sh script: "cd terraform; /usr/local/bin/terraform init; /usr/local/bin/terraform plan; /usr/local/bin/terraform apply -auto-approve"
               }
            }
            stage("Terraform GCP Provision") {
            when {
                expression { params.cloud == 'gcp' }
                expression { params.trigger == 'apply' }
                }
             steps{
                   sh script: "cd terraform; /usr/local/bin/terraform init; /usr/local/bin/terraform plan; /usr/local/bin/terraform apply -auto-approve"
               }
            }

            stage("Terraform AWS Destroy") {
            when {
                expression { params.cloud == 'aws' }
                expression { params.trigger == 'destroy' }
                }
             steps{
                   sh script: "cd terraform;  /usr/local/bin/terraform init; /usr/local/bin/terraform  destroy -auto-approve"
               }
            }
            stage("Terraform GCP Destroy") {
            when {
                expression { params.cloud == 'gcp' }
                expression { params.trigger == 'destroy' }
                }
             steps{
                   sh script: "cd terraform; /usr/local/bin/terraform init; /usr/local/bin/terraform  destroy -auto-approve"
               }
            }

      }
    }
