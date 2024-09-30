pipeline {
    agent {
        docker {
            image 'cirrusci/flutter:latest'
            args '-u root' // run as root user
        }
    }
    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                git 'https://github.com/chack0/Jenkins-Test.git'
            }
        }
        stage('Build') {
            steps {
                // Build the Flutter web app
                sh 'jenkis_test'
            }
        }
        stage('Deploy') {
            steps {
                // Run the Docker container
                sh 'docker build -t jenkis_test .'
                sh 'docker run -d -p 5000:5000 jenkis_test'
            }
        }
    }
}
