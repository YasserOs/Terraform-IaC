resource "aws_security_group" "public-secgp" {
  name   = "public-secgp"
  vpc_id = module.networks.vpc_id

  ingress {
    description = "ssh from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "public-secgp"
  }
}

resource "aws_security_group" "private-secgp" {
  name   = "private-secgp"
  vpc_id = module.networks.vpc_id

  ingress {
    description = "ssh from the vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [module.networks.vpc_cidr]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [module.networks.vpc_cidr]
  }
  tags = {
    "Name" = "private-secgp"
  }

}
