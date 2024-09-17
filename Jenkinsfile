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
        stage('Sending docker file to Ansible Server'){
            steps{
                script{
                    sshagent(['ansible']) {
                        sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229' // Ansible-Server
                        sh 'scp /var/lib/jenkins/workspace/pipeline-demo/* ec2-user@10.0.23.229:/home/ec2-user' //Path of jenkins server
                    }
                }
            }
        }
    }
}
