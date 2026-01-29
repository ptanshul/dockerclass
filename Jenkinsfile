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
