resource "aws_internet_gateway" "tf_internet_gw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "tf_internet_gw"
  }
}
resource "aws_nat_gateway" "Nat_gw" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.tf_pub_sub_1.id
  tags = {
    Name = "gw NAT"
  }
}


resource "aws_eip" "elastic_ip" {
  vpc = true
}



