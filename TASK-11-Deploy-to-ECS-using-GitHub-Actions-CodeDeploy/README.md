# 🚀 TASK-11: Deploy to ECS using GitHub Actions + CodeDeploy

## 📌 Objective
Automate deployment of a Docker container to AWS ECS using:
- Amazon ECR
- Amazon ECS (Fargate)
- AWS CodeDeploy
- GitHub Actions

---

## 🧱 Architecture

GitHub Push → GitHub Actions → Amazon ECR → ECS Task Definition Update → CodeDeploy → ECS Service

---

## 🔹 CI/CD Flow

1. Push code to main branch
2. GitHub Actions:
   - Build Docker image
   - Tag with GitHub Commit SHA
   - Push to Amazon ECR
   - Update ECS Task Definition dynamically
   - Trigger CodeDeploy deployment

---

## 🔐 AWS Region
us-east-1

---

## 🧠 DevOps Concepts Used
- Docker
- Amazon ECR
- Amazon ECS (Fargate)
- AWS CodeDeploy
- GitHub Actions CI/CD
- Blue/Green Deployment