pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                sh 'terraform init'
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Security Scan - tfsec') {
            steps {
                sh 'docker run --rm -v ${WORKSPACE}:/src aquasec/tfsec /src'
            }
        }

        stage('Security Scan - Checkov') {
            steps {
                sh 'docker run --rm -v ${WORKSPACE}:/src bridgecrew/checkov --directory /src'
            }
        }

        stage('Verify Docker Image Running') {
            steps {
                sh 'docker ps'
            }
        }
    }
}
