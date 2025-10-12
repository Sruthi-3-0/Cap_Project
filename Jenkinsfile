pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Sruthi-3-0/Cap_Project.git',
                    credentialsId: 'github-creds'
            }
        }

        stage('Cleanup Existing Docker Container') {
            steps {
                bat 'docker rm -f nginx_demo || echo "No existing container"'
            }
        }

        stage('Terraform Init & Apply') {
            environment {
                VAULT_ADDR = "http://127.0.0.1:8200"
                VAULT_TOKEN = credentials('vault-token')
            }
            steps {
                bat 'terraform init'
                bat 'terraform apply -auto-approve -var "vault_addr=%VAULT_ADDR%" -var "vault_token=%VAULT_TOKEN%"'
            }
        }

        stage('Security Scan - tfsec') {
            steps {
                bat 'docker run --rm -v %WORKSPACE%:/src aquasec/tfsec /src'
            }
        }

        stage('Security Scan - Checkov') {
            steps {
                bat 'docker run --rm -v %WORKSPACE%:/src bridgecrew/checkov --directory /src'
            }
        }

        stage('Verify Docker Image Running') {
            steps {
                bat 'docker ps'
            }
        }
    }
}
