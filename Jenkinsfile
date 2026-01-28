pipeline {
    agent any

    environment {
        IMAGE_NAME = "dockerclass-nginx"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Files in workspace:"
                sh 'ls -l'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image"
                sh '''
                  docker version
                  docker info
                  docker build --progress=plain -t ${IMAGE_NAME}:latest .
                '''
            }
        }

        stage('Verify Image') {
            steps {
                sh "docker images | grep ${IMAGE_NAME}"
            }
        }
    }

    post {
        success {
            echo "Docker image built successfully ✅"
        }
        failure {
            echo "Docker image build failed ❌"
        }
    }
}
