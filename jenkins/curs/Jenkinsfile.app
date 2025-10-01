pipeline {

    agent any

    environment {
        TAG = "${BUILD_NUMBER}"
        DOCKERHUB_CREDENTIALS_ID = 'dockerhub-creds-id'
        DOCKERHUB_CREDENTIALS = credentials("${DOCKERHUB_CREDENTIALS_ID}")
        IMAGE_NAME = "${DOCKERHUB_CREDENTIALS_USR}/curs-app"
        WORKDIR = "jenkins/curs"
    }

    stages {

        agent { docker { image 'python:3.11' } }
        stage('Lint - verific sintaxa') {
            steps {
              dir("${WORKDIR}") {
                  sh 'printenv'
                  sh 'pip install flake8'
                  sh 'python3 -m flake8 .'
              }
            }
        }

        stage('Test') {
            agent { docker { image 'python:3.11' } }
            steps {
                dir("${WORKDIR}") {
                    sh 'pip install -r requirements.txt'
                    sh 'python3 -m pytest . --junitxml=report.xml'
                    junit 'report.xml'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dir("${WORKDIR}") {
                        dockerImage = docker.build("${IMAGE_NAME}:${TAG}")
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKERHUB_CREDENTIALS_ID}") {
                        dockerImage.push()
                        // Push latest tag too (optional)
                        dockerImage.push('latest')
                    }
                }
            }

            post {
                success {
                    echo 'Push-ul a fost efectuat cu succes!'
                    echo "Vezi imaginea aici: https://hub.docker.com/repository/docker/${IMAGE_NAME}"
                }
                failure {
                    echo 'Push-ul a eșuat! Verifica logurile.'
                }
            }
        }

        
    }
}