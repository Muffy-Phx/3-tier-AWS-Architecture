module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.tag_name}-vpc"
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.pri_cidr
  public_subnets  = var.pub_cidr

 enable_nat_gateway = true
single_nat_gateway = true
one_nat_gateway_per_az = false
  enable_vpn_gateway = false

nat_gateway_tags = {
  Name = "${var.tag_name}-nat"
}

igw_tags = {
  "Name" = "${var.tag_name}-igw"
}

private_route_table_tags = {
  "Name" = "${var.tag_name}-private-rtb"
}
public_route_table_tags = {
  "Name" = "${var.tag_name}-public-rtb"
}

  tags = {
    Name  = "${var.tag_name}-VPC"
    Email = "mufaddal.suratwala@intuitive.cloud"
  }
}

resource "aws_ec2_tag" "public_subnet_tag" {
  count=3
  resource_id    = module.vpc.public_subnets[count.index]
  key            = "Name"
  value          = "${var.tag_name}-subnet-${var.pub_names[count.index]}"
}
resource "aws_ec2_tag" "private_subnet_tag" {
  count=6
  resource_id    = module.vpc.private_subnets[count.index]
  key            = "Name"
  value          = "${var.tag_name}-subnet-${var.pri_names[count.index%3]}"
}