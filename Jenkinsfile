pipeline {

    environment {
        git_url = "https://github.com/VibishnathanG/Website1.git"
        git_branch = "master"
    }

    agent any

    stages {
        stage("Pull Source"){
            steps {
            git credentialsId: '0a5bcc44-5ffe-494a-ad1e-f82880bc48d2', branch: "master", url: "${git_url}"
        }

        }

        /*stage("Maven Build"){
            steps {
                sh 'echo due to no Jar involved this is sameple Build step'
            }
        }*/

        stage("Remove Old Container"){
            steps{
                script{
                    sh "chmod +x RemoveOldContainer.sh"
                    sh "./RemoveOldContainer.sh"
                }
            }
        }

        stage("Docker Image Build"){
            steps {
                sh "docker image prune -a -f"
                sh 'docker build -t mywebsite .'
            }
        }

        stage("Docker Image Push"){
            steps {

                 withCredentials([usernamePassword(credentialsId: '	f34f79d9-39e2-430b-a834-2011a20020fe', passwordVariable: 'Password', usernameVariable: 'Username')]){
                    sh "docker login -u ${env.Username} -p ${env.Password}"
                    sh 'docker image tag mywebsite vibishnathan/mywebsite:latest'
                    sh 'docker image push vibishnathan/mywebsite:latest'
                 }

            }
        }

        stage('Deploy'){
            steps {
                script{
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
   } }
 }  
