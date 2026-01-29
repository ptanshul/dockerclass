pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                sh '''
                pwd
                ls -l
                DOCKER_BUILDKIT=0 docker build -f Dockerfile -t nginx-static-site .
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
