provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "kubernetes_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "kubernetes_subnet" {
  vpc_id     = aws_vpc.kubernetes_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "kubernetes_security_group" {
  name_prefix = "kubernetes-"
  vpc_id      = aws_vpc.kubernetes_vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "kubernetes_iam_role" {
  name = "kubernetes-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_instance_profile" "kubernetes_iam_instance_profile" {
  name = "kubernetes-iam-instance-profile"

  role = aws_iam_role.kubernetes_iam_role.name
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "terraform-state-bucket"
}

resource "aws_instance" "kubernetes_master" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.medium"
  key_name      = "my-ssh-key"
  vpc_security_group_ids = [aws_security_group.kubernetes_security_group.id]
  subnet_id     = aws_subnet.kubernetes_subnet.id
  user_data = <<-EOF
              #!/bin/bash
              echo "Installing Kubernetes master node"
              sudo kubeadm init --pod-network-cidr=192.168.0.0/16
              mkdir -p $HOME/.kube
              sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
              sudo chown $(id -u):$(id -g) $HOME/.kube/config
              kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
              EOF
}

resource "aws_instance" "kubernetes_worker" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.medium"
  key_name      = "my-ssh-key"
  vpc_security_group_ids = [aws_security_group.kubernetes_security_group.id]
  subnet_id     = aws_subnet.kubernetes_subnet.id
  user_data     = <<-EOF
              #!/bin/bash
              echo "Installing Kubernetes worker node"
              sudo kubeadm join ${aws_instance.kubernetes_master.private_ip}:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
              EOF

  depends_on = [aws_instance.kubernetes_master]
}

output "kubernetes_master_private_ip" {
  value = aws_instance.kubernetes_master.private_ip
}
