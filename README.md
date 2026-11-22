# AWS & Infrastructure Capstone Project

![Terraform CI](https://github.com/14230467/capstone-project/actions/workflows/terraform-checks.yml/badge.svg)

A comprehensive capstone project showcasing cloud infrastructure automation, DevOps practices, and modern deployment strategies using AWS, Terraform, Docker, Kubernetes, and Ansible.

## Table of Contents

1. [AWS & Terraform Fundamentals](#aws--terraform-fundamentals)
2. [Infrastructure Automation](#infrastructure-automation)
3. [Container & Orchestration](#container--orchestration)
4. [CI/CD & GitOps](#cicd--gitops)
5. [Monitoring & Logging](#monitoring--logging)
6. [Security & Access Control](#security--access-control)

---

## AWS & Terraform Fundamentals

### Project 01 - AWS Terraform Webserver
Deploy a basic EC2 webserver instance using Terraform with custom networking configuration and user data scripts.
- **Technologies**: Terraform, AWS EC2, Security Groups, VPC
- **Key Learnings**: IaC fundamentals, resource provisioning, state management

### Project 02 - Static Website
Deploy a static website on AWS using S3 and CloudFront for content delivery.
- **Technologies**: Terraform, S3, CloudFront, DNS
- **Key Learnings**: Serverless hosting, CDN distribution, DNS configuration

### Project 03 - EC2 State Monitoring
Monitor EC2 instance states and transitions using CloudWatch and SNS notifications.
- **Technologies**: Terraform, AWS EC2, CloudWatch, SNS
- **Key Learnings**: Resource monitoring, alerting systems, state tracking

### Project 04 - IAM User Automation
Automate IAM user creation and policy management with Terraform.
- **Technologies**: Terraform, AWS IAM, Access Control
- **Key Learnings**: Identity management, policy enforcement, least privilege principle

### Project 12 - Terraform Plan
Master Terraform planning and execution workflows with plan validation.
- **Technologies**: Terraform, CI/CD pipelines
- **Key Learnings**: Plan/apply workflows, dry-run validation

---

## Infrastructure Automation

### Project 05 - Secure Linux Permissions
Implement and verify secure file permissions and ownership on Linux systems.
- **Technologies**: Linux, File Permissions, Security Hardening
- **Key Learnings**: Permission models, security best practices

### Project 06 - Version Control Infrastructure
Manage infrastructure code using Git with branching strategies and collaborative workflows.
- **Technologies**: Git, Version Control, Infrastructure Code
- **Key Learnings**: Code versioning, collaboration, audit trails

### Project 11 - Infra Changes Branch Policy
Enforce branch protection policies for infrastructure changes with pull request workflows.
- **Technologies**: GitHub, Branch Policies, Code Review
- **Key Learnings**: Change management, peer review, governance

### Project 15 - Automate Server with Ansible
Automate server provisioning and configuration using Ansible playbooks.
- **Technologies**: Terraform, Ansible, Configuration Management
- **Key Learnings**: Infrastructure automation, idempotency, agentless management

### Project 20 - Load Balanced App
Deploy highly available applications using load balancers and auto-scaling.
- **Technologies**: Terraform, AWS ELB/ALB, Auto Scaling, EC2
- **Key Learnings**: High availability, load balancing, scaling strategies

---

## Container & Orchestration

### Project 08 - Build Docker App
Create and containerize a web application using Docker.
- **Technologies**: Docker, Containerization, Image Building
- **Key Learnings**: Dockerfile creation, image layers, container best practices

### Project 13 - Build Image & Push to ECR
Build Docker images and push them to AWS Elastic Container Registry.
- **Technologies**: Docker, AWS ECR, Image Registries
- **Key Learnings**: Container registry management, image versioning, CI/CD integration

### Project 14 - App Deployment using EKS
Deploy containerized applications on AWS Kubernetes Service (EKS).
- **Technologies**: Kubernetes, AWS EKS, Helm, YAML manifests
- **Key Learnings**: Container orchestration, pod management, Kubernetes primitives

---

## CI/CD & GitOps

### Project 07 - CI Validation
Set up CI pipeline to validate infrastructure code and run automated tests.
- **Technologies**: GitHub Actions, CI/CD, Terraform validation
- **Key Learnings**: Automated validation, testing pipelines, fail-fast strategies

### Project 18 - GitOps Infra Deployment
Implement GitOps principles for automated infrastructure deployment from Git repositories.
- **Technologies**: GitOps, ArgoCD/Flux, Kubernetes, Git
- **Key Learnings**: Declarative infrastructure, Git-driven deployments, continuous synchronization

---

## Monitoring & Logging

### Project 17 - Log Forwarding to CloudWatch
Stream application and system logs to AWS CloudWatch for centralized monitoring.
- **Technologies**: AWS CloudWatch, Log Agents, Log Streams
- **Key Learnings**: Log aggregation, centralized monitoring, troubleshooting

### Project 21 - CloudWatch Monitoring Dashboard
Create comprehensive monitoring dashboards in CloudWatch to visualize application and infrastructure metrics.
- **Technologies**: AWS CloudWatch, Dashboards, Metrics, Alarms
- **Key Learnings**: Custom dashboards, metric visualization, operational insights

---

## Security & Access Control

### Project 09 - Domain Controller Setup
Set up and configure a domain controller for centralized identity management.
- **Technologies**: Active Directory, Domain Services, Windows Server
- **Key Learnings**: Identity services, domain management, authentication

### Project 16 - Enable HTTPS with ACM
Implement HTTPS encryption using AWS Certificate Manager and configure TLS/SSL.
- **Technologies**: AWS ACM, HTTPS, SSL/TLS, Load Balancers
- **Key Learnings**: Certificate management, encryption in transit, security hardening

### Project 19 - Scheduled S3 Backup
Automate scheduled backups to S3 with IAM roles and Lambda/cron jobs.
- **Technologies**: AWS S3, IAM Roles, Lambda, Scheduling
- **Key Learnings**: Backup automation, access control, disaster recovery

### Project 22 - S3 Log Archive & Lifecycle
Implement S3 lifecycle policies for automatic log archival and retention management.
- **Technologies**: AWS S3, Lifecycle Policies, Glacier, Archive
- **Key Learnings**: Data lifecycle management, cost optimization, retention policies

### Project 23 - IAM Role-based Access
Implement fine-grained role-based access control using IAM roles and policies.
- **Technologies**: AWS IAM, Roles, Policies, RBAC
- **Key Learnings**: Access control design, principle of least privilege, role-based security

### Project 24 - Manual Chaos Testing
Conduct chaos engineering tests to validate system resilience and recovery procedures.
- **Technologies**: Chaos Engineering, Incident Management, Testing
- **Key Learnings**: Resilience validation, failure scenario testing, documentation

---

## Getting Started

### Prerequisites
- AWS Account with appropriate permissions
- Terraform >= 1.0
- Docker and Docker CLI
- kubectl (for Kubernetes projects)
- Ansible (for automation projects)
- Git

### Setup
```bash
# Clone the repository
git clone https://github.com/14230467/capstone-project.git
cd capstone-project

# Navigate to a specific project
cd project01-aws-terraform-webserver

# Initialize Terraform (if applicable)
terraform init

# Apply configuration
terraform apply
```

### Project Structure
```
capstone-project/
├── project01-aws-terraform-webserver/
├── project02-static-website/
├── project03-ec2-state-monitoring/
├── ... (additional projects)
├── project24-manual-chaos-test/
└── README.md
```

## CI/CD Pipeline
This repository includes GitHub Actions workflows for automated testing and validation:
- Terraform format validation
- Terraform plan generation
- Security scanning
- Code quality checks

## Contributing
Contributions are welcome! Please follow these guidelines:
1. Create a feature branch (`git checkout -b feature/improvement`)
2. Commit changes with clear messages
3. Push to the branch (`git push origin feature/improvement`)
4. Submit a pull request with detailed description

## License
This project is provided as-is for educational purposes.

## Contact
For questions or issues, please open an issue in the GitHub repository.