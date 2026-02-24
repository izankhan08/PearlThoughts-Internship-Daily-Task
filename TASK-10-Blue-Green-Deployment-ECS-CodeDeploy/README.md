# 🚀 Task-10: Blue/Green Deployment using AWS ECS, ALB & CodeDeploy (Terraform)

## 📌 Project Overview

This project demonstrates a production-grade Blue/Green deployment strategy using:

- ✅ AWS ECS (Fargate)
- ✅ Application Load Balancer (ALB)
- ✅ AWS CodeDeploy
- ✅ Terraform (Infrastructure as Code)

The objective was to implement **zero-downtime deployment** with automated traffic shifting using Canary strategy.

---

# 🧱 Architecture Diagram (Logical Flow)

User  
⬇  
Application Load Balancer (ALB)  
⬇  
Target Groups (Blue & Green)  
⬇  
ECS Fargate Service  
⬇  
Task Definition  

CodeDeploy controls traffic shifting between Blue and Green environments.

---

# 🎯 Objective

- Implement Blue/Green deployment
- Ensure zero downtime
- Automate infrastructure provisioning using Terraform
- Use Canary traffic shifting strategy
- Validate deployment using health checks

---

# 🌍 AWS Infrastructure Details

| Resource | Configuration |
|----------|--------------|
| Region | us-east-1 |
| Launch Type | Fargate |
| CPU | 256 |
| Memory | 512 MiB |
| Load Balancer | Application Load Balancer |
| Target Groups | izan-blue, izan-green |
| Deployment Type | Blue/Green |
| Deployment Strategy | Canary (10% for 5 minutes) |
| Deployment Config | CodeDeployDefault.ECSCanary10Percent5Minutes |
| Container Image | nginx:latest |

---

# ⚙️ Key Components

## 🔹 1. ECS Cluster
- Fargate-based cluster
- Managed service deployment
- CODE_DEPLOY deployment controller enabled

## 🔹 2. ECS Service
- Connected to ALB
- Uses Blue/Green deployment
- Desired count: 1
- Deployment controller: CODE_DEPLOY

## 🔹 3. Application Load Balancer
- Internet-facing
- Two subnets (different AZs)
- Listener: HTTP (Port 80)
- Routes traffic to Blue & Green target groups

## 🔹 4. Target Groups
- izan-blue
- izan-green
- Health check enabled
- Port: 80

## 🔹 5. CodeDeploy
- Deployment group configured for ECS
- Canary 10% → 100% traffic shifting
- Automatic rollback enabled
- Wait time before terminating Blue environment

---

# 🔄 Blue/Green Deployment Flow

1️⃣ New task definition revision created  
2️⃣ CodeDeploy creates replacement task set  
3️⃣ 10% traffic shifted to Green environment  
4️⃣ Health checks validated  
5️⃣ 100% traffic shifted  
6️⃣ Original (Blue) task set terminated  

This ensures **zero downtime deployment**.

---

# 📂 Project Structure

TASK-10-Blue-Green-Deployment-ECS-CodeDeploy
│
├── alb.tf
├── ecs.tf
├── codedeploy.tf
├── security.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── appspec.yaml
├── README.md
└── screenshots/


---

# 📜 Important Terraform Files

| File | Purpose |
|------|---------|
| ecs.tf | ECS cluster, service, task definition |
| alb.tf | ALB, listener, target groups |
| codedeploy.tf | CodeDeploy app & deployment group |
| security.tf | Security group rules |
| provider.tf | AWS provider configuration |
| appspec.yaml | CodeDeploy ECS configuration |

---

# 🌐 Public Access Verification

Application verified via ALB DNS:

http://izan-task10-alb-xxxxxxxx.us-east-1.elb.amazonaws.com

Nginx welcome page successfully loaded through ALB.
---


---

# 🧠 DevOps Concepts Implemented

- Infrastructure as Code (Terraform)
- Blue/Green Deployment Strategy
- Canary Deployment
- ECS Fargate
- Application Load Balancer
- CodeDeploy Traffic Shifting
- IAM Role Configuration
- Health Checks
- Zero Downtime Deployment
- Deployment Lifecycle Hooks

---

# ⚠️ Challenges Faced & Resolved

- IAM permission issues for CodeDeploy
- Target group conflicts
- ALB subnet configuration error
- ECS service update restriction with CODE_DEPLOY controller
- Task definition inactive revision issue

All issues were successfully debugged and resolved.

---

# 📊 Deployment Outcome

✅ Blue/Green deployment successful  
✅ Traffic shifted automatically  
✅ Health checks validated  
✅ Zero downtime achieved  
✅ Infrastructure fully automated via Terraform  

---

# 🏁 Final Result

Successfully implemented production-level Blue/Green deployment using:

- AWS ECS Fargate
- Application Load Balancer
- AWS CodeDeploy
- Terraform

This project demonstrates real-world DevOps deployment strategy.

---

# 👨‍💻 Author

Mohammad Izan Khan  
PearlThoughts DevOps Internship  
