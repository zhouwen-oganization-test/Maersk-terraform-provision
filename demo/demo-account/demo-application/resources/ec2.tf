locals {
  ec2_config_name     = "config/ec2.yaml"
  ec2_instance_config = yamldecode(file("${path.module}/${local.ec2_config_name}"))
  templates_config    = { for t in try(local.ec2_instance_config.templates, []) : t.name => t }
}

variable "windows_pam_user_password" {
  default = "RotateMe"
}

module "ec2_instances" {
  # source                    = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-ec2"
  source                    = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-ec2?ref=main"
  instance_config           = local.ec2_instance_config
  templates_config          = local.ec2_templates_config
  # account_alias_id_map      = {}
  windows_pam_user_password = var.windows_pam_user_password
}
