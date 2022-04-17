resource "tls_private_key" "private_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "public_key_pair" {
  key_name   = "ubuntu-key-2"
  public_key = tls_private_key.private_key_pair.public_key_openssh
  provisioner "local-exec" { # Create "ubuntu-key-1.pem" to your computer!!
    command = "echo '${tls_private_key.private_key_pair.private_key_pem}' > ./ubuntu-key-2.pem"
  }
}

resource "aws_secretsmanager_secret" "private_key_2" {
  name = "private_key_2"
}

resource "aws_secretsmanager_secret" "public_key_2" {
  name = "public_key_2"
}

resource "aws_secretsmanager_secret_version" "private_key_secret" {
  secret_id     = aws_secretsmanager_secret.private_key_2.id
  secret_string = tls_private_key.private_key_pair.private_key_pem
}

resource "aws_secretsmanager_secret_version" "public_key_secret" {
  secret_id     = aws_secretsmanager_secret.public_key_2.id
  secret_string = aws_key_pair.public_key_pair.public_key
}