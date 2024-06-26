pipeline {
    agent any
    
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('capstone_id')
        GIT_REPO_URL = 'https://github.com/bharath11112001/projectcapstone.git'
        GIT_CREDENTIALS_ID = 'git-cap'
    }
    
    stages {
        stage('Checkout SCM') {
            steps {
                script {
                    // Ensure BRANCH_NAME is set, defaulting to 'Dev' if not specified
                    def branch = env.BRANCH_NAME ?: 'Dev'
                    echo "Checking out branch: ${branch}"
                    
                    // Checkout SCM using scmGit command
                    checkout([$class: 'GitSCM',
                              branches: [[name: "*/${branch}"]],
                              doGenerateSubmoduleConfigurations: false,
                              extensions: [],
                              userRemoteConfigs: [[url: GIT_REPO_URL,
                                                   credentialsId: GIT_CREDENTIALS_ID]]])
                    
                    // Set the BRANCH_NAME environment variable
                    env.BRANCH_NAME = branch
                }
            }
        }
        
        stage('Build') {
            steps {
                script {
                    sh 'chmod +x build.sh'
                    sh './build.sh'
                }
            }
        }
        
        stage('Debug Branch Name') {
            steps {
                script {
                    echo "BRANCH_NAME environment variable: ${env.BRANCH_NAME}"
                }
            }
        }
        
        stage('Push to Docker Hub') {
            when {
                expression {
                    // Push to Docker Hub only for main or Dev branches
                    env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'Dev'
                }
            }
            steps {
                script {
                    echo "Branch name is: ${env.BRANCH_NAME}"
                    if (env.BRANCH_NAME == 'main') {
                        echo 'Pushing to Prod repository'
                        sh '''
                            docker tag mynginximg bharath883/prod:latest
                            echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin
                            docker push bharath883/prod:latest
                        '''
                    } else if (env.BRANCH_NAME == 'Dev') {
                        echo 'Pushing to Dev repository'
                        sh '''
                            docker tag mynginximg bharath883/dev:latest
                            echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin
                            docker push bharath883/dev:latest
                        '''
                    } else {
                        echo 'Branch is not main or Dev. Skipping Docker push.'
                    }
                }
            }
        }
        
        stage('Deploy') {
            when {
                expression {
                    // Deploy only if branch is 'main' or 'Dev'
                    env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'Dev'
                }
            }
            steps {
                script {
                    // Clean up previous deployments
                    sh 'docker-compose down'
                    
                    // Ensure deploy.sh is executable and run it with branch name argument
                    sh 'chmod +x deploy.sh'
                    sh "./deploy.sh ${env.BRANCH_NAME}"
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
