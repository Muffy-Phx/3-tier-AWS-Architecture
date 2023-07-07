module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "${var.tag_name}-Alb"

  load_balancer_type = "application"
  create_security_group = false

  vpc_id             = module.vpc.vpc_id
  subnets            = ["${element(module.vpc.public_subnets, 0)}","${element(module.vpc.public_subnets, 1)}","${element(module.vpc.public_subnets, 2)}"]
    security_groups    = [module.web_server_sg.security_group_id]

  target_groups = [
    {
      name_prefix      = "muffy"
      backend_protocol = var.http_protocol
      backend_port     = var.http_port
      ip_address_type="ipv4"
      target_type  = var.resource_type
      stickiness= {
      enabled=true
      type="lb_cookie"
      }
      
    }
  ]
 https_listeners = [
    {
      port               = var.https_port
      protocol           = var.https_protocol
      certificate_arn    = var.cert_arn
      target_group_index = 0
    }
    
  ]

  http_tcp_listeners = [
    {
      port               = var.http_port
      protocol           = var.http_protocol
       action_type="redirect"
       redirect = {
        port        = var.https_port
        protocol    = var.https_protocol
        status_code = "HTTP_301"
      }
     
    }
  ]

  tags = {
    Name="${var.tag_name}-alb"
  }
 
}

