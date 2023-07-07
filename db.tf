module "db" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = "muffydb"

  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  allocated_storage = 5

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = var.db_port

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [module.db_sg.security_group_id]


  tags = {
    Owner= "mufaddal.suratwala@intuitive.cloud"
    Name = "${var.tag_name}-DB"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids= ["${element(module.vpc.private_subnets, 3)}","${element(module.vpc.private_subnets, 4)}","${element(module.vpc.private_subnets, 5)}"]

  # DB parameter group
  family = "${var.db_engine}${var.db_engine_version}"

  # DB option group
  major_engine_version = var.db_engine_version

  # Database Deletion Protection
  deletion_protection = false
  storage_encrypted = false
  create_random_password=false
 skip_final_snapshot  = true

}