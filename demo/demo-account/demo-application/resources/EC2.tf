locals {
  config_name = "config/EC2.yaml"
  account_config = yamldecode(file("${path.module}/${local.config_name}"))
  templates_config = { for t in try(local.account_config.templates, []) : t.name => t }
}

data "aws_partition" "this" {}
data "aws_caller_identity" "this" {}
data "aws_region" "this" {}

variable "windows_pam_user_password" {
  default = "RotateMe"
}

module "tag_defs" {
  # source     = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-ec2-demo/tag-defs"
  source     = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-ec2-demo/tag-defs?ref=main"
  tag_defs   = try(local.account_config.tag_defs, [])
}

module "ec2_instances" {
  # source                    = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-ec2-demo"
  source                    = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-ec2-demo?ref=main"
  account_config            = local.account_config
  templates_config          = local.templates_config
  tag_defs_template         = module.tag_defs.template
  account_alias_id_map      = {}
  windows_pam_user_password = var.windows_pam_user_password
}