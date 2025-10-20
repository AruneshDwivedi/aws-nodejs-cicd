# AWS Node.js CI/CD Pipeline (Terraform + Ansible + Jenkins)

## Overview
This project demonstrates an automated CI/CD pipeline for a Node.js app using:
- **Terraform** – to provision AWS EC2
- **Ansible** – to configure and deploy the app
- **Jenkins** – to orchestrate the build/deploy pipeline

## Steps
1. Clone repo → `git clone https://github.com/AruneshDwivedi/aws-nodejs-cicd`
2. Run `terraform init && terraform apply` in the `terraform/` folder.
3. Update `ansible/inventory.ini` with the EC2 public IP.
4. Run Ansible manually:  
   `ansible-playbook -i ansible/inventory.ini ansible/node_service.yml`
5. Or let Jenkins do it automatically (Pipeline job).
6. Access the app via: `http://<EC2-Public-IP>`

## Project Structure
