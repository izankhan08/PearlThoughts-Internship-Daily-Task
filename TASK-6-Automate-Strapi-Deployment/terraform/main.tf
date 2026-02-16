resource "aws_instance" "strapi" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name      = "strapi-key"

  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  associate_public_ip_address = true

  user_data = <<-EOF
#!/bin/bash
apt update -y
apt install docker.io -y
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

docker pull ${var.docker_user}/strapi-task6:${var.image_tag}
docker run -d -p 1337:1337 ${var.docker_user}/strapi-task6:${var.image_tag}
EOF

  tags = {
    Name = "Strapi-Task6"
  }
}