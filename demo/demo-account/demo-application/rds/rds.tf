locals {
  rds_config_name      = "config/rds.yaml"
  rds_config           = yamldecode(file("${path.module}/${local.rds_config_name}"))
  rds_templates_config = { for t in try(local.rds_config.templates, []) : t.name => t }
}

module "rds_instances" {
  # source = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-rds"
  source                    = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-rds?ref=main"
  rds_config                = local.rds_config
  templates_config          = local.rds_templates_config
}
