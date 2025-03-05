pipeline {
    agent { label 'agent1' }

    environment {
        DOCKER_IMAGE = 'shrutiv05/tomcat-image'
        DOCKERHUB_CREDENTIALS = 'docker-hub-key'
    }

    stages {
        stage('Clone the git repository') {
            steps {
                git branch: 'main', url: 'https://github.com/shrutiverma05/java-project.git'
            }
        }

        stage('Maven Build') {
            steps {
                sh 'mvn clean package -DskipTests'
                sh "mv target/*.war target/tomapp-${BUILD_TAG}.war"
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                script {
                    echo "Deploying to Tomcat..."
                    sh "cp target/tomapp-${BUILD_TAG}.war /opt/tomcat9/webapps/tomapp.war"
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh """
                    docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} .
                """
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKERHUB_CREDENTIALS}",
                    usernameVariable: 'DOCKERHUB_USERNAME',
                    passwordVariable: 'DOCKERHUB_PASSWORD'
                )]) {
                    sh '''
                        echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin
                        docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}
                    '''
                }
            }
        }
    }
}

