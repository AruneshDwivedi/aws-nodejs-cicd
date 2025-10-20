provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "devops_key" {
  key_name   = "devops-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "app_server" {
  ami           = "ami-0e2ff28bfb72a4e45" # Ubuntu 22.04 in ap-south-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.devops_key.key_name
  tags = { Name = "nodejs-app-server" }

  security_groups = [aws_security_group.app_sg.name]
}

resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Allow HTTP and SSH"
  ingress = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  ]
  egress = [{ from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }]
}