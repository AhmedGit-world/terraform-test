// Jenkinsfile
pipeline {
    agent any

    environment {
        // These variables are automatically populated by the 'aws-credentials' ID
        AWS_ACCESS_KEY_ID       = credentials('aws-credentials')
        AWS_SECRET_ACCESS_KEY = credentials('aws-credentials')
        TF_VAR_region           = "us-east-1" // Example for passing a Terraform variable, adjust as needed
    }

    stages {
        stage('Checkout') {
            steps {
                // This line is crucial for checking out your specific repository and branch
                git branch: 'main', url: 'https://github.com/AhmedGit-world/terraform-test.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan' // Save the plan to a file
            }
        }

        stage('Terraform Apply') {
            steps {
                input 'Approve to apply Terraform changes?' // Requires manual approval
                sh 'terraform apply -auto-approve tfplan' // Apply the saved plan
            }
        }

        stage('Terraform Destroy (Optional)') {
            steps {
                input 'Approve to destroy Terraform resources? (Type "yes" to confirm)'
                sh 'terraform destroy -auto-approve'
            }
        }
    }

    post {
        always {
            // Clean up workspace after build
            cleanWs()
        }
        failure {
            script {
                echo 'Pipeline failed!'
                // Add notifications or other actions on failure
            }
        }
        success {
            script {
                echo 'Pipeline succeeded!'
                // Add notifications or other actions on success
            }
        }
    }
}
