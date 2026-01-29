pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        AWS_ACCOUNT_ID = "779846806653"
        ECR_REPO = "779846806653.dkr.ecr.us-east-1.amazonaws.com/nginx-static-site"
        IMAGE_NAME = "nginx-static-site"
        IMAGE_TAG = "latest"
        EKS_CLUSTER = "my-eks-cluster"
    }

    stages {

        stage('Checkout Source Code') {
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
                withCredentials([[
                  $class: 'AmazonWebServicesCredentialsBinding',
                  credentialsId: 'aws-ecr'
                ]]) {
                    sh '''
                      aws ecr get-login-password --region ${AWS_REGION} \
                      | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    '''
                }
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
                withCredentials([[
                  $class: 'AmazonWebServicesCredentialsBinding',
                  credentialsId: 'aws-ecr'
                ]]) {
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
    }

    post {
        success {
            echo "✅ Build, Push to ECR, and Deploy to EKS completed successfully"
        }
        failure {
            echo "❌ Pipeline failed"
        }
    }
}
