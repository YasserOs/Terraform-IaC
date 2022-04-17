module "networks" {
    source = "./networks"
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    az1 = var.az1
    az2 = var.az2
    pub_sub_1_cidr = var.pub_sub_1_cidr
    pub_sub_2_cidr = var.pub_sub_2_cidr
    prv_sub_1_cidr = var.prv_sub_1_cidr
    prv_sub_2_cidr = var.prv_sub_2_cidr
}