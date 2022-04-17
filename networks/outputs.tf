output "vpc_cidr" {
    value = aws_vpc.tf_vpc.cidr_block
}
output "vpc_id" {
    value = aws_vpc.tf_vpc.id
}
output "pub_sub1_id" {
    value = aws_subnet.tf_pub_sub_1.id
}
output "pub_sub2_id" {
    value = aws_subnet.tf_pub_sub_2.id
}
output "prv_sub1_id" {
    value = aws_subnet.tf_pv_sub_1.id
}
output "prv_sub2_id" {
    value = aws_subnet.tf_pv_sub_2.id
}