# 🚀 Task-6: Automate Strapi Deployment using GitHub Actions + Terraform

## 📌 Objective
The goal of this task is to automate the deployment of a Dockerized Strapi application on an AWS EC2 instance using a CI/CD pipeline built with GitHub Actions and Terraform.

---

## 🧱 Architecture

Developer Push → GitHub Actions (CI) → DockerHub → Terraform (CD) → AWS EC2 → Docker Container → Live Strapi App

---

## 🔹 CI Pipeline (GitHub Actions)

**Trigger:** Push to `main` branch

The CI workflow performs the following steps:

1. Checkout repository
2. Generate Docker image tag from commit SHA
3. Login to DockerHub using GitHub Secrets
4. Build Docker image of Strapi application
5. Push image to DockerHub

### Docker Image Format
```
dockerhub-username/strapi-task6:<commit-sha>
```

---

## 🔹 CD Pipeline (Terraform Deployment)

**Trigger:** Manual (`workflow_dispatch`)

The CD workflow performs:

1. Terraform init
2. Terraform plan
3. Terraform apply
4. Create EC2 instance (Ubuntu t2.micro)
5. Install Docker automatically using user_data
6. Pull latest Docker image from DockerHub
7. Run Strapi container on port 1337

---

## 🔐 AWS Infrastructure Details

| Resource | Configuration |
|--------|------|
| Region | us-east-1 |
| Instance Type | t2.micro |
| AMI | Ubuntu |
| Security Group | SSH (22) + Strapi (1337) |
| Deployment | Automated via Terraform |

---

## 🌍 Live Application

The Strapi application is accessible publicly via:

```
http://<public-ip>:1337
```

---

## 🧠 Key DevOps Concepts Used

- Docker containerization
- GitHub Actions CI/CD pipelines
- Terraform Infrastructure as Code
- AWS EC2 provisioning
- Environment variables management
- Automated application deployment

---

## 📂 Project Structure

```
TASK-6-Automate-Strapi-Deployment
│
├── app/                  # Strapi Application
├── terraform/            # Infrastructure code
├── .github/workflows/
│   ├── ci.yml            # Build & Push Docker image
│   └── terraform.yml     # Deploy to AWS
└── Dockerfile
```

---

## 📸 Screenshots

- CI workflow success
- Terraform deployment success
- AWS EC2 instance running
- Strapi admin panel live

---

## ✅ Result

Successfully implemented a complete automated CI/CD pipeline that:

- Builds Docker image on code push
- Pushes image to DockerHub
- Deploys infrastructure using Terraform
- Runs Strapi container on AWS EC2
- Makes application publicly accessible

---

## 👨‍💻 Author
Mohammad Izan Khan