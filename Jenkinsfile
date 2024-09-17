pipeline {
    agent any  // Chạy pipeline trên bất kỳ agent nào

    stages {
        stage('Cleanup Workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Git checkout') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/Code-Cafe-IT/Kubernetes_Project.git'
            }
        }
    }
}
