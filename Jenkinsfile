pipeline {
    // This pipeline will run on the Jenkins controller (master node)
    agent any
    stages {
        stage('Checkout Terraform Code') {
            steps {
                // Fetch your Terraform code (main.tf and Jenkinsfile) from GitHub
                // Use your actual GitHub repository URL and branch
                git url: 'https://github.com/AhmedGit-world/terraform-test.git', // Your GitHub URL
                    branch: 'main'                                            // Your branch
            }
        }

        stage('Deploy S3 Bucket in us-east-1') {
            steps {
                script {
                    // Securely load AWS credentials stored in Jenkins.
                    // 'aws-credentials' is the ID you configured in Jenkins Credentials Manager.
                    withCredentials([aws(credentialsId: 'aws-credentials')]) {

                        // 1. Initialize Terraform
                        // This prepares Terraform, downloads plugins, and configures the S3 backend for state.
                        // IMPORTANT: The 'bucket' and 'region' here MUST match the backend config in your main.tf.
                        sh 'terraform init -backend-config="bucket=ahmed-terraform-state-20250609-us-east" -backend-config="region=us-east-1"'

                        // 2. Create a Terraform plan
                        // This command shows you exactly what changes Terraform will make (add the S3 bucket).
                        sh 'terraform plan -out=tfplan'

                        // 3. Manual Approval (Good for safety, especially in initial runs)
                        // This pauses the pipeline and waits for you to click 'Proceed'.
                        input message: 'Review the plan. Proceed to deploy the S3 bucket in us-east-1?', ok: 'Deploy'

                        // 4. Apply the Terraform plan
                        // This command actually creates the S3 bucket in your AWS account.
                        sh 'terraform apply -auto-approve tfplan'

                        // 5. Show the output (the name of the created bucket)
                        sh 'terraform output'
                    }
                }
            }
        }
    }

    // Post-build actions: always clean up the workspace and provide status messages.
    post {
        always {
            cleanWs() // Clear the build workspace
        }
        success {
            echo "S3 bucket deployment in us-east-1 finished successfully!"
        }
        failure {
            echo "S3 bucket deployment in us-east-1 failed! Check logs."
        }
    }
}
