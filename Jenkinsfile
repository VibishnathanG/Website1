pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    // Your build steps here
                    echo 'Building the code...'
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    // Your Docker build and push steps here
                    sh 'docker build -t your-docker-username/your-app-name:your-tag .'
                    sh 'docker push your-docker-username/your-app-name:your-tag'
                }
            }
        }

        stage('Kubernetes Deployment') {
            steps {
                script {
                    // Your Kubernetes deployment steps here
                    sh 'kubectl apply -f your-deployment.yaml'
                    sh 'kubectl apply -f your-service.yaml'
                }
            }
        }
    }
}
