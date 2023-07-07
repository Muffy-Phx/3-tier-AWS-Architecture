module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "${var.tag_name}-asg"

  min_size                  = 3
  max_size                  = 4
  desired_capacity          = 3
  health_check_type         = "EC2"
  vpc_zone_identifier       = ["${element(module.vpc.private_subnets, 0)}","${element(module.vpc.private_subnets, 1)}","${element(module.vpc.private_subnets, 2)}"]
  target_group_arns = module.alb.target_group_arns


  launch_template_name        = "${var.tag_name}-asg"
  launch_template_description = "Instances of type t2.micro for app layer"
  image_id          =  data.aws_ami.ec2_ami.id
  instance_type     = var.inst_type
  security_groups = [module.ec2_sg.security_group_id]
  user_data = base64encode(templatefile("hello.tftpl",{ db_name = module.db.db_instance_address }))

  tag_specifications= [{
    resource_type = var.resource_type

    tags = {
      Name = "${var.tag_name} EC2"
    }
  }]
 

    #IAM
  create_iam_instance_profile = true
  iam_role_name               = "ec2-role"
  iam_role_policies = {
    "rds-full-access" = var.rds_full_access
    "ssm-full-access" = var.ssm_full_access
  }



  tags={
    Name="${var.tag_name}-lt"
    Owner="mufaddal.suratwala@intuitive.cloud"
  }
    
 create_launch_template = true
}


data "aws_ami" "ec2_ami" {
  most_recent = true
  owners      = ["amazon"]


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}




