pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                // We stay inside the Jenkins workspace (.), no moving to /tmp
                sh '''
                echo "Building Docker image in the current workspace..."
                docker build -t nginx-static-site .
                '''
            }
        }

        stage('Run NGINX Container') {
            steps {
                sh '''
                echo "Cleaning up old containers and starting new one..."
                docker rm -f nginx-site || true
                docker run -d -p 8081:80 --name nginx-site nginx-static-site
                '''
            }
        }
    }
}
