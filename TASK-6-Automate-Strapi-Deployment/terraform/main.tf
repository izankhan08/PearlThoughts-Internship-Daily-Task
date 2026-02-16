resource "aws_instance" "strapi" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "devops-strapi"

  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [aws_security_group.strapi_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
#!/bin/bash
apt update -y
apt install -y docker.io

systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

# Pull latest image
docker pull ${var.docker_user}/strapi-task6:${var.image_tag}

# Run Strapi with required secrets
docker run -d -p 1337:1337 \
  -e HOST=0.0.0.0 \
  -e PORT=1337 \
  -e APP_KEYS="appKey1,appKey2,appKey3,appKey4" \
  -e API_TOKEN_SALT="apisalt123" \
  -e ADMIN_JWT_SECRET="adminjwtsecret123" \
  -e JWT_SECRET="jwtsecret123" \
  --name strapi \
  ${var.docker_user}/strapi-task6:${var.image_tag}

EOF

  tags = {
    Name = "Strapi-Task6"
  }
}