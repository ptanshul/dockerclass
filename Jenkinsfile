pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        ECR_REPO   = "779846806653.dkr.ecr.us-east-1.amazonaws.com/nginx-static-site"
        IMAGE_NAME = "nginx-static-site"
        IMAGE_TAG  = "latest"
        EKS_CLUSTER = "my-eks-cluster"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Login to AWS ECR') {
            steps {
                sh '''
                  aws ecr get-login-password --region ${AWS_REGION} \
                  | docker login --username AWS --password-stdin \
                  779846806653.dkr.ecr.${AWS_REGION}.amazonaws.com
                '''
            }
        }

        stage('Tag & Push Image to ECR') {
            steps {
                sh '''
                  docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${ECR_REPO}:${IMAGE_TAG}
                  docker push ${ECR_REPO}:${IMAGE_TAG}
                '''
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh '''
                  aws eks update-kubeconfig \
                    --region ${AWS_REGION} \
                    --name ${EKS_CLUSTER}

                  kubectl apply -f deployment.yaml
                  kubectl apply -f service.yaml
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Image pushed to ECR and deployed to EKS successfully'
        }
        failure {
            echo '❌ Deployment failed'
        }
    }
}
