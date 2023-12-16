pipeline {

    environment {
        git_url = "https://github.com/VibishnathanG/Website1.git"
        git_branch = "master"
    }

    agent any

    steps {
        stage("Pull Source"){
            step {
            git credentialsId: '0a5bcc44-5ffe-494a-ad1e-f82880bc48d2', git_branch: '${git_branch}', url: "${git_url}"
        }

        }

        stage("Maven Build"){
            step{
                sh 'echo due to no Jar involved this is sameple Build step'
            }
        }

        stage("Docker Image Build"){
            step{
                sh 'docker build -t mywebsite .'
            }
        }

        stage("Docker Image Push"){
            step{

                 withCredentials([usernamePassword(credentialsId: '	f34f79d9-39e2-430b-a834-2011a20020fe', passwordVariable: 'Password', usernameVariable: 'Username')]){
                    sh "docker login -u ${env.Username} -p ${env.Password}"
                    sh 'docker image tag mywebsite vibishnathan/mywebsite:latest'
                    sh 'docker image push vibishnathan/mywebsite:latest'
                 }

            }
        }

        stage('Deploy'){
            step{
                sh "docker run -it vibishnathan/mywebsite:latest -p 82:80 mypod"
            }
        }
        }
//   post {
//   always {
//    deleteDir() /* cleanup the workspace */
//   } }
 }  
