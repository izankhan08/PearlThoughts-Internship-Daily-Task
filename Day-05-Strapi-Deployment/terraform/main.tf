resource "aws_security_group" "strapi_sg" {
  name        = "strapi-security-group"
  description = "Allow HTTP and SSH"

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

resource "aws_instance" "strapi_server" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install docker -y
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ec2-user

              docker pull mdizankhan/strapi-app:latest
              docker run -d -p 80:1337 mdizankhan/strapi-app:latest
              EOF

  tags = {
    Name = "Strapi-Terraform-Server"
  }
}