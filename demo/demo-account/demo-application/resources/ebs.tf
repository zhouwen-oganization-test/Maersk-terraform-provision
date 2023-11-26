locals {
  ebs_config_name      = "config/ebs.yaml"
  ebs_config  = yamldecode(file("${path.module}/${local.ebs_config_name}"))
  ebs_templates_config = { for t in try(local.ebs_config.templates, []) : t.name => t }
}

module "ebs_volumes" {
  # source                    = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-ebs-demo"
  source                    = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-ebs?ref=main"
  instance_config           = local.ebs_config
  templates_config          = local.ebs_templates_config

}
