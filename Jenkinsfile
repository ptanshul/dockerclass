pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            steps {
                sh '''
                echo "Current Directory: $(pwd)"
                echo "Listing all files in workspace:"
                ls -la
                
                # We try to build. If it fails, the 'ls' above will tell us why.
                docker build -t nginx-static-site .
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
