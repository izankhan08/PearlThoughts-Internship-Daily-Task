# 🚀 TASK-11: Blue-Green Deployment to Amazon ECS using GitHub Actions & CodeDeploy

---

## 📌 Objective

To build a fully automated CI/CD pipeline that deploys a Dockerized application to **Amazon ECS (Fargate)** using:

- Amazon ECR
- Amazon ECS
- AWS CodeDeploy (Blue-Green Deployment)
- GitHub Actions
- Terraform (Infrastructure as Code)

The primary goal was to achieve **zero-downtime deployment** using a Blue-Green strategy.

---

## 🧱 Architecture

Developer Push
↓
GitHub Actions (CI/CD)
↓
Amazon ECR (Docker Image)
↓
ECS Task Definition (New Revision)
↓
AWS CodeDeploy (Blue-Green Deployment)
↓
Application Load Balancer (ALB)
↓
Live ECS Service (Fargate)


---

## ⚙️ Technologies Used

- GitHub Actions (CI/CD)
- Docker
- Amazon ECR
- Amazon ECS (Fargate)
- AWS CodeDeploy
- Application Load Balancer (ALB)
- Terraform (Infrastructure as Code)
- AWS CLI + jq

---

## 🔹 CI/CD Workflow

### 🔁 Trigger:
Push to `main` branch

### ⚙️ Pipeline Steps:

1. Checkout repository
2. Build Docker image
3. Tag image with GitHub Commit SHA
4. Push image to Amazon ECR
5. Fetch existing ECS Task Definition
6. Replace container image dynamically
7. Register new ECS Task Definition revision
8. Trigger CodeDeploy Blue-Green deployment
9. Shift traffic from old task set to new task set

---

## 🔄 Blue-Green Deployment Strategy

- Two target groups: **Blue & Green**
- New version deployed to Green environment
- Traffic shifted via ALB
- Old task set terminated after success
- Zero downtime achieved

---

## 🔐 AWS Region

us-east-1


---

## 🗂 Infrastructure (Terraform)

Terraform was used to provision:

- ECS Cluster
- ECS Service
- Task Definition
- Application Load Balancer
- Target Groups (Blue & Green)
- CodeDeploy Application
- Deployment Group

Terraform state files were removed from the repository for security best practices.

---

## 📂 Project Structure

TASK-11-Deploy-to-ECS-using-GitHub-Actions-CodeDeploy
│
├── Dockerfile
├── terraform/
│ ├── provider.tf
│ ├── ecs.tf
│ ├── alb.tf
│ ├── codedeploy.tf
│ ├── service.tf
│ ├── variables.tf
│
├── screenshots/
├── README.md
│
└── .github/workflows/
└── task-11-ecs-codedeploy.yml


---

## 📸 Deployment Proof

Screenshots included for:

- GitHub Actions successful run
- Amazon ECR image push
- ECS Cluster & Service running
- Task Definition revision update
- CodeDeploy Blue-Green success
- ALB traffic shift
- Live application running

Available inside:

/screenshots


---

## 🧠 DevOps Concepts Demonstrated

- CI/CD Automation
- Docker Image Versioning
- Infrastructure as Code
- Blue-Green Deployment
- Zero-Downtime Release Strategy
- Dynamic ECS Task Updates
- Production-Grade AWS Deployment Pipeline

---

## ✅ Final Outcome

✔ Fully automated deployment pipeline  
✔ Docker image versioning using Git commit SHA  
✔ Dynamic ECS task definition updates  
✔ Blue-Green deployment using CodeDeploy  
✔ Zero downtime achieved  
✔ Clean and production-ready GitHub repository  

---

## 👨‍💻 Author

**Mohammad Izan Khan**  
DevOps Intern – PearlThoughts  
