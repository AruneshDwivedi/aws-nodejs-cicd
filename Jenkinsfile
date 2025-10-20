pipeline {
  agent any
  environment {
    AWS_REGION = 'ap-south-1'
    ANSIBLE_HOST_KEY_CHECKING = 'False'
  }
  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/AruneshDwivedi/aws-nodejs-cicd.git'
      }
    }
    stage('Terraform Init & Apply') {
      steps {
        dir('terraform') {
          sh 'terraform init'
          sh 'terraform apply -auto-approve'
        }
      }
    }
    stage('Ansible Deploy') {
      steps {
        dir('ansible') {
          sh 'ansible-playbook -i inventory.ini node_service.yml'
        }
      }
    }
  }
  post {
    success {
      echo 'Deployment successful! Access the app via the EC2 public IP.'
    }
    failure {
      echo 'Deployment failed. Check logs.'
    }
  }
}
