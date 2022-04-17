resource "aws_subnet" "tf_pub_sub_1" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = var.pub_sub_1_cidr

  tags = {
    Name = "tf_pub_sub_1"
  }
  availability_zone       = var.az1
  map_public_ip_on_launch = true
}
resource "aws_subnet" "tf_pub_sub_2" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = var.pub_sub_2_cidr

  tags = {
    Name = "tf_pub_sub_2"
  }
  availability_zone       = var.az2
  map_public_ip_on_launch = true
}
resource "aws_subnet" "tf_pv_sub_1" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = var.prv_sub_1_cidr

  tags = {
    Name = "tf_pv_sub_1"
  }
  availability_zone = var.az1
}
resource "aws_subnet" "tf_pv_sub_2" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = var.prv_sub_2_cidr

  tags = {
    Name = "tf_pv_sub_2"
  }
  availability_zone = var.az2
}