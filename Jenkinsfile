pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('capstone_id')
        GIT_REPO_URL = 'https://github.com/bharath11112001/projectcapstone.git'
        GIT_CREDENTIALS_ID = 'git-cap'
        BRANCH_NAME = "${env.GIT_BRANCH.split('/').last()}"
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    git branch: BRANCH_NAME, url: GIT_REPO_URL, credentialsId: GIT_CREDENTIALS_ID
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    sh 'chmod +x build.sh'
                    sh 'echo ${DOCKER_HUB_CREDENTIALS_PSW} | sudo -S ./build.sh'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh 'docker-compose down'
                    sh 'chmod +x deploy.sh'
                    sh "echo ${DOCKER_HUB_CREDENTIALS_PSW} | sudo -S ./deploy.sh ${BRANCH_NAME}"
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up...'
                sh 'docker logout'
            }
        }
        
        failure {
            script {
                echo 'Deployment failed.'
            }
        }
    }
}

