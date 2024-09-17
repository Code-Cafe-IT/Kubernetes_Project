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
                        sh 'scp -r /var/lib/jenkins/workspace/pipeline-demo/* ec2-user@10.0.23.229:/home/ec2-user' //Path of jenkins server
                    }
                }
            }
        }
        stage('Docker Build Image'){
            steps{
                script{
                    sshagent(['ansible']) {
                        sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 cd /home/ec2-user/'
                        sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 docker image build -t $JOB_NAME:v1.$BUILD_ID .'
                        sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 docker image build -t $JOB_NAME:latest .'
                    }
                }
            }
        }
        stage('Push to DockerHub'){
            steps{
                script{
                    sshagent(['ansible']) {
                        withCredentials([gitUsernamePassword(credentialsId: 'dockerhub', gitToolName: 'Default')]) {
                            sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 docker login -u minhduccloud -p $dockerhub '
                            sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 docker push minhduccloud/pipeline-demo:v1.$BUILD_ID '
                            sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 docker push minhduccloud/pipeline-demo:latest '
                        }
                    }
                }
            }
        }
    }
}
