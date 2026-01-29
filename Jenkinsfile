pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            steps {
                sh '''
                # Create a visible directory (Snap can't see hidden .jenkins folder)
                mkdir -p /home/jenkins/docker-build
                cp Dockerfile index.html /home/jenkins/docker-build/
        
                # Build from the visible directory
                cd /home/jenkins/docker-build
                docker build -t nginx-static-site .
        
                # Clean up
                rm -rf /home/jenkins/docker-build
                '''
            }
        }
        stage('Run NGINX Container') {
            steps {
                sh '''
                docker rm -f nginx-site || true
                docker run -d -p 8081:80 --name nginx-site nginx-static-site
                '''
            }
        }
    }
}
