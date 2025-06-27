resource "aws_key_pair" "generated" {
  key_name   = var.key_name
  public_key = file("${path.module}/secrets/demo-infra.pub")

  tags = merge(var.tags, {
    Name = var.key_name
  })
}

resource "aws_security_group" "ec2_sg" {
  name        = "allow_ssh"
  description = "Allow SSH"
  vpc_id      = var.vpc_id

  # SSH to the EC2
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Get the HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Expose the Minikube'API server port
  ingress {
    from_port   = 32771
    to_port     = 32771
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "ec2-ssh-sg"
  })
}

resource "aws_instance" "minikube" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.generated.key_name

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  user_data = file("${path.module}/scripts/install-minikube.sh")

  tags = merge(var.tags, {
    Name = "ec2-public-instance"
  })
}
