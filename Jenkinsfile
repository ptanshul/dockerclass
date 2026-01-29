pipeline {
    agent any
    
    stages {
        stage('Build Docker Image') {
            steps {
                sh '''
                # Prepare a visible build context for Snap Docker
                mkdir -p ~/docker-build
                cp Dockerfile index.html ~/docker-build/
                
                # Execute Build
                docker build -t nginx-static-site ~/docker-build/
                
                # Cleanup build context
                rm -rf ~/docker-build
                '''
            }
        }

        stage('Run NGINX Container') {
            steps {
                sh '''
                # Idempotent deployment: remove old, start new
                docker rm -f nginx-site || true
                docker run -d -p 8081:80 --name nginx-site nginx-static-site
                '''
            }
        }
    }
}
