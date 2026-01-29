pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        ECR_REPO   = "779846806653.dkr.ecr.us-east-1.amazonaws.com/nginx-static-site"
        IMAGE_NAME = "nginx-static-site"
        IMAGE_TAG  = "latest"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                  docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                """
            }
        }

        stage('Login to AWS ECR') {
            steps {
                sh """
                  aws ecr get-login-password --region ${AWS_REGION} \
                  | docker login --username AWS --password-stdin \
                  779846806653.dkr.ecr.${AWS_REGION}.amazonaws.com
                """
            }
