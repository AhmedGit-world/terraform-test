pipeline {
    agent { label 'terraform' }

    environment {
        REGION = 'us-east-1'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/your-org/terraform-s3-repo.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-credential', region: "${env.REGION}") {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-credential', region: "${env.REGION}") {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'aws-credential', region: "${env.REGION}") {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
