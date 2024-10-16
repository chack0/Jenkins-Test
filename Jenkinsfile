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




// pipeline {
//     agent any
    
//     environment {

//         DOCKER_IMAGE = 'my-jenkins-deploy/flutter-web-app:latest' // Set your Docker image name
//     }
    
//     stages {
//         stage('Checkout') {
//             steps {
//                 // Clone the repository
//                 git url: 'https://github.com/chack0/Jenkins-Test.git', branch: 'main'
//             }
//         }
        
//         stage('Install Dependencies') {
//             steps {
//                 echo "This is at flutter"
//                 // Install Flutter dependencies
//                 sh 'flutter pub get'
//             }
//         }

//         stage('Build Web App') {
//             steps {
//                 // Build the Flutter web app
//                 sh 'flutter build web'
//             }
//         }
        
//         stage('Archive Build') {
//             steps {
//                 // Archive the built files
//                 archiveArtifacts artifacts: 'build/web/**', allowEmptyArchive: true
//             }
//         }
        
//         stage('Build Docker Image') {
//         agent any
//             steps {
//                 script {
//                     // Build the Docker image using the Dockerfile
//                     sh 'docker build -t $DOCKER_IMAGE .'
//                 }
//             }
//         }

//         stage('Run Docker Container') {
//         agent any    
//             steps {
//                 script {
//                     // Run the Docker container, map port 80 to the host machine’s port 8080
//                     sh 'docker run -d -p 8080:80 $DOCKER_IMAGE'
//                 }
//             }
//         }
        
//     }    
    
//     post {
//         success {
//             echo 'Deployment finished successfully!'
//         }
//         failure {
//             echo 'Deployment failed!'
//         }
//         always {
//             // Clean up workspace to ensure a fresh start for the next run
//             cleanWs()
//         }
//     }
// }