locals {
  ebs_config_name      = "config/ebs.yaml"
  ebs_instance_config  = yamldecode(file("${path.module}/${local.config_name}"))
  ebs_templates_config = { for t in try(local.instance_config.templates, []) : t.name => t }
}

# data "aws_partition" "this" {}
# data "aws_caller_identity" "this" {}
# data "aws_region" "this" {}


module "ebs_volumes" {
  # source                    = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-ebs-demo"
  source                    = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-ebs?ref=main"
  instance_config           = local.ebs_instance_config
  templates_config          = local.ebs_templates_config
  # account_alias_id_map      = {}
  # windows_pam_user_password = var.windows_pam_user_password
}
