resource "aws_route53_record" "www" {
  zone_id = var.pub_hosted_zone
  name    = "mufaddalsuratwala"
  type    = "CNAME"
    records = [module.alb.lb_dns_name]
ttl="5"
}


module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"
  
  zone_id = var.pub_hosted_zone

  records = [

    {
      name    = "muffysuratwala"
      type    = "CNAME"
      ttl     = 5
      records = [module.alb.lb_dns_name]
            # set_identifier = "https"

    }

  ]

}

module "rds_records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"
  
  zone_id = var.pri_hosted_zone

  records = [

    {
      name    = "muffy-rds"
      type    = "CNAME"
      ttl     = 5
      records = [module.db.db_instance_address]
            # set_identifier = "https"

    },

  ]

}

resource "aws_route53_zone_association" "private" {
  zone_id = var.pri_hosted_zone
  vpc_id  = module.vpc.vpc_id
}