#############
### Count ###
#############
resource "aws_instance" "name" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  tags = {
    "Name" = "dev-${random_id.name.hex}"
  }
  security_groups = [aws_security_group.security.name]
  key_name        = aws_key_pair.generated_key.key_name
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "terraform-key"
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "null_resource" "generated_key" {
  provisioner "local-exec" {
    command = <<-EOT
        echo '${tls_private_key.private_key.private_key_pem}' > ./'${random_id.name.hex}'.pem
        chmod 400 ./'${random_id.name.hex}'.pem
      EOT
  }
}