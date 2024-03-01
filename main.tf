module "iam" {
   source="./iam" 
  
}
module "rdss" {
  source = "./rds"
  role_arnn = module.iam.iam_role
}

resource "aws_db_instance_role_association" "rds_iam_auth_association" {
  db_instance_identifier = module.rdss.myrds1
  feature_name           = "iam_auth"
    role_arn          = module.iam.iam_role
}
