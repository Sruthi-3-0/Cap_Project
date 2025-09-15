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

        stage('Terraform Init & Apply') {
            steps {
                bat 'terraform init'
                bat 'terraform apply -auto-approve'
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
