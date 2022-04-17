resource "aws_route" "pub_route" {
  route_table_id         = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tf_internet_gw.id
  depends_on = [
    aws_route_table.public_rtb
  ]
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "public_rtb"
  }
}

resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.tf_pub_sub_1.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.tf_pub_sub_2.id
  route_table_id = aws_route_table.public_rtb.id
}

####################
#private associations

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.Nat_gw.id
}

resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "private_rtb"
  }
}
resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.tf_pv_sub_1.id
  route_table_id = aws_route_table.private_rtb.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.tf_pv_sub_2.id
  route_table_id = aws_route_table.private_rtb.id
}

