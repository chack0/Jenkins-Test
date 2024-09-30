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
                git 'https://github.com/your-repo/flutter-web-app.git'
            }
        }
        stage('Build') {
            steps {
                // Build the Flutter web app
                sh 'flutter build web'
            }
        }
        stage('Deploy') {
            steps {
                // Run the Docker container
                sh 'docker build -t flutter-web-app .'
                sh 'docker run -d -p 5000:5000 flutter-web-app'
            }
        }
    }
}
