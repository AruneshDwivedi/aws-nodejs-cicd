# AWS Node.js CI/CD Pipeline (Terraform + Ansible + Jenkins)

A production-ready CI/CD pipeline for deploying a Node.js service to AWS EC2 using Jenkins, Terraform for infrastructure provisioning, and Ansible for configuration management.

## Architecture Overview

- **Cloud Provider**: AWS (EC2)
- **CI/CD**: Jenkins
- **Infrastructure as Code**: Terraform
- **Configuration Management**: Ansible
- **Application**: Node.js Express service

## Prerequisites

- AWS Account with appropriate permissions
- Jenkins server (installed and configured)
- Terraform installed locally (v1.0+)
- Ansible installed locally (v2.9+)
- SSH key pair for AWS EC2 access
- Git repository for your application

## Project Structure

```
.
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── ansible/
│   ├── node_service.yml
│   ├── inventory.ini
│   └── roles/
│       ├── server-setup/
│       │   └── tasks/
│       │       └── main.yml
│       └── app/
│           └── tasks/
│               └── main.yml
├── src/
│   ├── index.js
│   └── package.json
├── Jenkinsfile
└── README.md
```

## Setup Instructions

### 1. Infrastructure Provisioning with Terraform

Create an AWS EC2 instance using Terraform. Navigate to the terraform directory, initialize Terraform, review the planned changes, and apply the configuration to provision your infrastructure.

**Key Resources Created:**
- AWS EC2 instance (Ubuntu/Amazon Linux)
- Security Group (ports 80, 443, 22)
- Elastic IP (optional)
- VPC configuration

### 2. Server Configuration with Ansible

Run the server setup playbook to configure your EC2 instance. This will update system packages, install Node.js and npm, configure firewall rules, and set up required system dependencies.

### 3. Application Setup

The Node.js service provides a simple health check endpoint at the root path that returns "Hello, world!". The application runs on port 80 and is accessible via the EC2 public IP address.

## Task 1: Manual Ansible Deployment

The `app` role handles application deployment. Run the Ansible playbook with the app tag to deploy your application.

**What this does:**
1. Connects to the EC2 instance via SSH
2. Clones the latest code from the Git repository
3. Installs Node.js dependencies
4. Builds the application (if applicable)
5. Restarts the application service
6. Ensures the app is running on port 80

You can verify the deployment by accessing the EC2 public IP address and confirming the response.

## Task 2: Automated Deployment with Jenkins

### Jenkins Pipeline Setup

**Create Jenkins Pipeline Job:**
- Create a new Pipeline item in Jenkins
- Configure your Git repository URL
- Point to the Jenkinsfile in your repository

**Configure Jenkins Credentials:**
- AWS credentials (Access Key ID & Secret Access Key)
- SSH private key for EC2 access
- Git repository credentials (if private)

**Environment Variables in Jenkins:**
Set up AWS region, EC2 host IP address, and disable Ansible host key checking for automated deployments.

### Deployment Method: Ansible Playbook via Jenkins

The Jenkins pipeline executes the Ansible playbook to deploy the application. The pipeline includes stages for checking out code, deploying via Ansible, and verifying the deployment.

### Pipeline Stages

1. **Checkout**: Pull latest code from Git
2. **Test**: Run unit tests (optional)
3. **Deploy**: Execute Ansible playbook with the app tag
4. **Verify**: Health check on the deployed application

### Triggering Deployments

- **Manual**: Click "Build Now" in Jenkins
- **Webhook**: Configure Git webhook to trigger on push to main branch
- **Scheduled**: Use cron syntax for scheduled deployments

## Security Configuration

### Jenkins Secrets

Store sensitive data in Jenkins Credentials including AWS access keys, SSH private keys, and Git credentials.

### AWS Security Group Rules

Configure security groups to allow HTTP traffic on port 80 from all sources, and SSH traffic on port 22 restricted to your Jenkins server IP address only.

## Testing the Pipeline

1. Make a change to your application code
2. Commit and push to your Git repository
3. Trigger Jenkins build (manual or automatic via webhook)
4. Monitor Jenkins console output for deployment progress
5. Verify the application is accessible via the EC2 public IP

## Monitoring & Logs

- **Application logs**: Check via SSH on EC2 instance
- **Jenkins logs**: Available in build console output
- **AWS CloudWatch**: Configure for EC2 metrics (optional)

## Troubleshooting

### Common Issues

**Issue: Ansible can't connect to EC2**
- Verify SSH connectivity manually
- Check security group allows port 22 from Jenkins server

**Issue: Application not accessible on port 80**
- Check if app is running on the server
- Verify security group allows port 80

**Issue: Jenkins pipeline fails during Ansible execution**
- Verify Ansible is installed on Jenkins agent
- Check SSH key permissions (should be 600)
- Ensure inventory file has correct EC2 IP address

## Future Enhancements

- Add Docker containerization
- Implement blue-green deployments
- Add automated rollback on failure
- Integrate with AWS CodeDeploy
- Set up monitoring with Prometheus/Grafana
- Implement automated testing in pipeline
- Add Slack/email notifications

## Resources

- Terraform AWS Provider Documentation
- Ansible Documentation
- Jenkins Pipeline Syntax
- AWS EC2 Documentation



## Contributing

Pull requests are welcome! Feel free to submit issues or suggestions.

---

**Project Status**: Production Ready

**Last Updated**: October 2025
