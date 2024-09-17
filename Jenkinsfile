pipeline {
    agent any  // Chạy pipeline trên bất kỳ agent nào
    environment{
        DOCKER_USER = "minhduccloud"
    }

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
                        sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 docker tag $JOB_NAME:v1.$BUILD_ID ${DOCKER_USER}/$JOB_NAME:v1.$BUILD_ID'
                        sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 docker tag $JOB_NAME:latest ${DOCKER_USER}/$JOB_NAME:latest'
                    }
                }
            }
        }
        stage('Push to DockerHub'){
            steps{
                script{
                    sshagent(['ansible']) {
                        withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) {
                            sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 docker login -u ${DOCKER_USER} -p ${dockerhub}'
                            sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 docker push ${DOCKER_USER}/$JOB_NAME:v1.$BUILD_ID'
                            sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 docker push ${DOCKER_USER}/$JOB_NAME:latest'
                        }
                    }
                }
            }
        }
        stage('Sending manifest to K8s Server'){
            steps{
                script{
                    sshagent(['k8s']) {
                        sh 'ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 cd /home/ec2-user/' // Ansible-Server
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 sed -i 's/$JOB_NAME.*/$JOB_NAME:v1.$BUILD_ID/g' Deployment.yml"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@10.0.23.229 ansible-playbook ansible.yml"
                    }
                }
            }
        }
    }
}
