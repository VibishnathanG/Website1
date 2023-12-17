pipeline {
    environment {
        git_url = "https://github.com/VibishnathanG/Website1.git"
        branchName = "${env.BRANCH_NAME ?: 'master'}"
    }

    agent any

    stages {
        stage("Pull Source") {
            steps {
                script{
                    git credentialsId: '0a5bcc44-5ffe-494a-ad1e-f82880bc48d2', branch: "${branchName}", url: "${git_url}"  
                    echo "Branch Name: ${branchName}" // Add this line
                }            
            }
        }

        stage("Maven Build") {
            steps {
                script {
                echo "due to no Jar involved this is a sample Build step"
                echo "Branch in build ${branchName}"
                }
                
            }
        }

        stage('Deploy') {
            when {
                expression { branchName == 'master' }
            }
            steps {
                script {
                    sh 'echo Removing Old Container'
                    sh "chmod +x RemoveOldContainer.sh"
                    sh "./RemoveOldContainer.sh"
                    sh 'echo Old Container Removed'

                    // Build Docker image and run container for master branch
                    sh 'echo Building Image'
                    sh 'docker image prune -a -f'
                    sh 'docker build -t mywebsite .'
                    withCredentials([usernamePassword(credentialsId: 'f34f79d9-39e2-430b-a834-2011a20020fe', passwordVariable: 'Password', usernameVariable: 'Username')]) {
                        sh "docker login -u ${env.Username} -p ${env.Password}"
                        sh 'docker image tag mywebsite vibishnathan/mywebsite:latest'
                        sh 'docker image push vibishnathan/mywebsite:latest'
                        sh 'echo Image Build Done and uploaded on https://hub.docker.com/repositories/vibishnathan'
                    }
                }

                script {
                    // Generate a dynamic container name
                    def containerName = "webserver-${BUILD_NUMBER}"
                    // Remove existing container if it exists
                    sh "docker rm -f ${containerName} || true"
                    // Build and run the container
                    sh "docker container run -d --name ${containerName} -p 82:80 vibishnathan/mywebsite:latest"
                }
            }
        }
    }
    post {
    always {
         deleteDir() /* cleanup the workspace */
    }
    }
}
