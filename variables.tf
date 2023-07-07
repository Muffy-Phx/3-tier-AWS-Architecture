variable "tag_name" {
  default = "Mufaddal-Suratwala"
}
variable "vpc_cidr" {
  default= "10.0.0.0/16"
}
variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "pub_cidr" {
  type    = list(any)
  default = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]

}

variable "pri_cidr" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

}

variable "region" {
  default="us-east-1"
}

variable "pub_names" {
  type=list
  default=["A","B","C"]
  
}

variable "pri_names" {
  type=list
  default=["A","B","C"] 
}

variable "inst_type" {
  default="t2.micro"
}

variable "db_engine" {
  default = "mysql"
}

variable "db_engine_version" {
  default = "5.7"
}

variable "db_instance_class" {
  default = "db.t2.micro"
}

variable "rds_full_access" {
  default="arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

variable "pub_hosted_zone" {
  default="0000000000000000"
}

variable "pri_hosted_zone" {
  default="0000000000000000"
}

variable "http_protocol" {
  default="HTTP"
}

variable "https_protocol" {
  default = "HTTPS"
}

variable "cert_arn" {
  default = "00000000000000000"
}

variable "ssm_full_access" {
  default = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

variable "resource_type" {
  default = "instance"
}

variable "route53_rds_endpoint" {
  default = ""
}

variable "http_port" {
  default = 80
}

variable "https_port" {
  default = 443
}

variable "db_port" {
  default = 3306
}

variable "tcp_protocol" {
  default = "tcp"
}

variable "egress_cidr" {
  default = "0.0.0.0/0"
}

variable "db_username" {
  default = "muffy"
}

variable "db_password" {
  default="muffy123"
}

variable "db_name" {
  default = "muffydb"
}
