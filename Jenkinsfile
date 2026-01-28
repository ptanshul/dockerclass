pipeline {
    agent any

    environment {
        IMAGE_NAME = "dockerclass-nginx"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "Code already checked out by Jenkins"
                sh 'ls -l'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image"
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Verify Docker Image') {
            steps {
                echo "Verifying Docker image"
                sh "docker images | grep ${IMAGE_NAME}"
            }
        }
    }

    post {
        success {
            echo "Docker image built successfully 🎉"
        }
        failure {
            echo "Docker build failed ❌"
        }
    }
}
