# 🚀 Task-7 — Automated Strapi Deployment on AWS ECS (EC2) using Terraform & GitHub Actions

## 📌 Project Overview

This project demonstrates a **fully automated CI/CD pipeline** to deploy a Strapi CMS application on **AWS ECS (EC2 launch type)**.

Every time code is pushed to the `main` branch, the system automatically:

1. Builds a Docker image
2. Tags the image using commit SHA
3. Pushes the image to Amazon ECR
4. Registers a new ECS Task Definition revision
5. Deploys the updated container to ECS service

No manual deployment steps are required.

---

## 🏗️ Architecture

Developer → GitHub → GitHub Actions → Docker Build → Amazon ECR → ECS Task Revision → ECS Service Deployment → Running Container

---

## 🛠️ Technologies Used

* **Strapi CMS**
* **Docker**
* **AWS ECS (EC2 launch type)**
* **Amazon ECR**
* **Terraform (Infrastructure as Code)**
* **GitHub Actions (CI/CD Automation)**

---

## 📂 Repository Structure

```
strapi-ecs-deploy/
│
├── .github/workflows/
│   └── deploy.yml          # CI/CD pipeline
│
├── terraform/              # Infrastructure configuration
│
├── config/                 # Strapi configuration
├── src/                    # Application source code
├── Dockerfile              # Container build file
├── docker-compose.yml      # Local development
├── package.json
└── README.md
```

---

## ⚙️ CI/CD Workflow

### Trigger

Push to `main` branch

### Pipeline Steps

1. Checkout repository
2. Authenticate with AWS
3. Build Docker image
4. Push image to ECR
5. Fetch current ECS task definition
6. Replace image with new tag
7. Register new task revision
8. Force new ECS deployment

---

## 🔄 Deployment Flow

```
git push
   ↓
GitHub Actions Triggered
   ↓
Docker Image Build
   ↓
Push to Amazon ECR
   ↓
New ECS Task Revision Created
   ↓
ECS Service Auto Deploy
   ↓
Application Updated
```

---

## 📦 Docker Image Tagging Strategy

Images are tagged using commit SHA:

```
<account-id>.dkr.ecr.<region>.amazonaws.com/strapi-ecs-repo:<commit-sha>
```

This ensures:

* Version tracking
* Rollback capability
* Unique deployments

---

## 🌐 Result

A complete automated deployment pipeline:

✔ Zero manual deployment
✔ Automatic container updates
✔ Version controlled releases
✔ Production-ready workflow

---

## 🧪 Verification

Deployment success can be verified by:

* GitHub Actions → Successful workflow run
* Amazon ECR → New image tag
* ECS → New task revision
* ECS Service → Steady state running task

---

## 🎯 Key Learning Outcomes

* Implemented Infrastructure as Code using Terraform
* Created production-style CI/CD pipeline
* Integrated GitHub Actions with AWS
* Automated container deployments
* Implemented rolling updates in ECS

---

## 👨‍💻 Author

**Mohammad Izan Khan**

---

## 📢 Conclusion

This project implements a real-world DevOps workflow where code commits automatically trigger build, versioning, container registry updates, and live production deployment without human intervention.
