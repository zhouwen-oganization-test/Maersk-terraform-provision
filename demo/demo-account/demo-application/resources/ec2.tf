locals {
  config_name = "config/ec2.yaml"
  instance_config = yamldecode(file("${path.module}/${local.config_name}"))
  templates_config = { for t in try(local.instance_config.templates, []) : t.name => t }
}

data "aws_partition" "this" {}
data "aws_caller_identity" "this" {}
data "aws_region" "this" {}

variable "windows_pam_user_password" {
  default = "RotateMe"
}

module "ec2_instances" {
  # source                    = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-ec2"
  source                    = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-ec2?ref=main"
  instance_config            = local.instance_config
  templates_config          = local.templates_config
  account_alias_id_map      = {}
  windows_pam_user_password = var.windows_pam_user_password
}
