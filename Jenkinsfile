pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                sh '''
                set -e

                echo "Preparing Docker build context in /tmp"
                rm -rf /tmp/docker-build
                mkdir -p /tmp/docker-build

                cp Dockerfile index.html /tmp/docker-build/
                cd /tmp/docker-build

                echo "Files in build context:"
                ls -l

                DOCKER_BUILDKIT=0 docker build -t nginx-static-site .
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
