data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "pub-ubuntu" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "ubuntu-key-2"
  vpc_security_group_ids = [aws_security_group.public-secgp.id]
  subnet_id              = module.networks.pub_sub1_id
  tags = {
    Name = "public-ec2-ubuntu"
  }
    provisioner "local-exec" {
    command = "echo public-ip of bastion ec2 : ${self.public_ip}"
  //  command = "sudo scp -i ubuntu-key-2.pem ubuntu-key-2.pem ubuntu@${self.public_ip}:~/"
  }
}

resource "aws_instance" "private-ubuntu" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "ubuntu-key-2"
  vpc_security_group_ids = [aws_security_group.private-secgp.id]
  subnet_id              = module.networks.prv_sub1_id     
  tags = {
    Name = "private-ec2-ubuntu"
  }
}