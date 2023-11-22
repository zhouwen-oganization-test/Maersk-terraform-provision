locals {
  config_name = "config/EC2.yaml"
  yaml_vars = yamldecode(file("${path.module}/${local.config_name}"))
}

locals {

  accounts_config = { for a in local.yaml_vars.accounts : a.account_alias => a }

  templates_config = { for t in try(local.yaml_vars.templates, []) : t.name => t }
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
  tag_defs   = try(local.yaml_vars.tag_defs, [])
}

module "ec2_instances" {
  # source                    = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-ec2-demo"
  source                    = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-ec2-demo?ref=main"
  account_config            = local.accounts_config["PRD-APP"]
  templates_config          = local.templates_config
  tag_defs_template         = module.tag_defs.template
#   account_alias_id_map      = data.terraform_remote_state.org.outputs.account_alias_id_map
  account_alias_id_map      = {}
  windows_pam_user_password = var.windows_pam_user_password
}