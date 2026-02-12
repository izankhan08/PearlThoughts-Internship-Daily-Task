# TASK-5: Deploy Strapi on EC2 using Terraform and Docker

## 📌 Objective

The objective of this task was to deploy a Strapi application on an AWS EC2 instance using Docker for containerization and Terraform for infrastructure automation.

The entire deployment process was automated using Infrastructure as Code (Terraform).

---

## 🏗️ Architecture Overview

```
Local Machine
   ↓
Docker Build
   ↓
Docker Hub
   ↓
Terraform provisions EC2
   ↓
user_data installs Docker
   ↓
EC2 pulls Docker image
   ↓
Strapi container runs on port 80
```

---

## 🐳 Step 1: Dockerizing the Strapi Application

### 1️⃣ Dockerfile

```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 1337

CMD ["npm", "run", "develop"]
```

### 2️⃣ .dockerignore

```
node_modules
.git
.env
```

---

## 🚀 Step 2: Build and Push Docker Image

### Build Image

```bash
docker build --no-cache -t <dockerhub-username>/strapi-app:latest .
```

### Push Image

```bash
docker push <dockerhub-username>/strapi-app:latest
```

The Docker image was pushed to Docker Hub and later pulled automatically by the EC2 instance.

---

## ☁️ Step 3: Infrastructure Automation using Terraform

### Terraform Files Used

- provider.tf  
- variables.tf  
- main.tf  

---

### provider.tf

```hcl
provider "aws" {
  region = "us-east-1"
}
```

---

### variables.tf

```hcl
variable "instance_type" {
  default = "t2.micro"
}
```

---

### main.tf

#### 🔐 Security Group Configuration

```hcl
resource "aws_security_group" "strapi_sg" {
  name = "strapi-security-group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

---

#### 🖥️ EC2 Instance Configuration

```hcl
resource "aws_instance" "strapi_server" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              systemctl start docker
              systemctl enable docker

              docker pull <dockerhub-username>/strapi-app:latest
              docker run -d -p 80:1337 -e HOST=0.0.0.0 <dockerhub-username>/strapi-app:latest
              EOF

  tags = {
    Name = "Strapi-Terraform-Server"
  }
}
```

---

## 🧪 Deployment Commands

```bash
terraform init
terraform plan
terraform apply
```

Terraform automatically:

- Created Security Group  
- Launched EC2 instance  
- Installed Docker  
- Pulled Docker image  
- Started Strapi container  

---

## 🌐 Final Result

Strapi was successfully deployed and accessible via:

```
http://<EC2-Public-IP>
```

The admin panel was accessible and fully functional.

---

## 🐛 Challenges Faced & Debugging

During deployment, the following issues were resolved:

- Invalid ELF header error (Windows vs Linux binary conflict)
- Large Docker build context
- Disk space issue on EC2
- Security group configuration
- Strapi binding to localhost instead of 0.0.0.0

All issues were successfully debugged and resolved.

---

## 📚 Learnings

- Docker containerization best practices
- Importance of .dockerignore
- Handling cross-platform binary issues
- Terraform EC2 provisioning
- Infrastructure automation using user_data
- Debugging container deployment in AWS

---

## 🎥 Demo Video

Loom Recording Link:

https://www.loom.com/share/e92ca64ba4d047b8b710d1119f18b728

---

## 👨‍💻 Author

**Mohammad Izan Khan**  
DevOps Intern – PearlThoughts