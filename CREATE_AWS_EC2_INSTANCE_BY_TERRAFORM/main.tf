# Generate new private key locally
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create key pair in AWS using generated public key
resource "aws_key_pair" "keypair" {
  key_name   = "ec2_key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Save private key to local file
resource "local_file" "private_key" {
  content              = tls_private_key.ssh_key.private_key_pem
  filename             = "nginx-key.pem"
  file_permission      = "0400"
  directory_permission = "0700"
}

# Security Group for SSH and HTTP
resource "aws_security_group" "nginx_sg" {
  name        = "nginx-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = "<add vpc id here"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance with NGINX installed via user_data
resource "aws_instance" "nginx_server" {
  ami                         = "<ami-value>"
  instance_type               = "t2.micro" 
  subnet_id                   = "<public-subnet-id>"
  key_name                    = aws_key_pair.keypair.key_name
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
  associate_public_ip_address = true
  iam_instance_profile = "<iam-instance-profile-name>"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install nginx -y
              systemctl enable nginx
              systemctl start nginx
              EOF

  tags = {
    Name = "nginx-instance"
  }
}

# Outputs
output "instance_public_ip" {
  description = "Public IP of the NGINX EC2 instance"
  value       = aws_instance.nginx_server.public_ip
}

output "private_key_file" {
  description = "Path to the private key saved locally"
  value       = local_file.private_key.filename
}
