module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.tag_name}-ALB-SG"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

    ingress_with_cidr_blocks = [
    {
      from_port   = var.http_port
      to_port     = var.http_port
      protocol    = var.tcp_protocol
      description = "HTTP Port 80"
      cidr_blocks = var.egress_cidr
    },

    {
    description = "HTTPS traffic for public subnet"
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = var.tcp_protocol
    cidr_blocks = var.egress_cidr
    }
   ]
   egress_with_cidr_blocks = [{
    from_port   = -1
    to_port     = -1
    protocol    = "-1"
    cidr_blocks = var.egress_cidr
   }]
   tags={
    Name="${var.tag_name}ALB SG"
   }
}

module "ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.tag_name}ALB-SG"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

   ingress_with_source_security_group_id =   [
    {
      from_port   = var.http_port
      to_port     = var.http_port
      protocol    = var.tcp_protocol
      description = "HTTP Port 80"
      source_security_group_id=module.web_server_sg.security_group_id
    
    },

    {
    description = "HTTPS traffic for public subnet"
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = var.tcp_protocol
    source_security_group_id=module.web_server_sg.security_group_id 

       }
   ]
   egress_with_cidr_blocks = [{
    from_port   = -1
    to_port     = -1
    protocol    = "-1"
    cidr_blocks = var.egress_cidr
   }]
   tags={
    Name="${var.tag_name}EC2 SG"
   }
}

module "db_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.tag_name}ALB-SG"
  description = "Security group for DB"
  vpc_id      = module.vpc.vpc_id

   ingress_with_source_security_group_id =   [
    {
      from_port   = var.db_port
      to_port     = var.db_port
      protocol    = var.tcp_protocol
      description = "Inbound for DB"
      source_security_group_id=module.ec2_sg.security_group_id
    }
   ]
   egress_with_cidr_blocks = [{
    from_port   = -1
    to_port     = -1
    protocol    = "-1"
    cidr_blocks = var.egress_cidr
   }]
   tags={
    Name="${var.tag_name}DB SG"
   }
}