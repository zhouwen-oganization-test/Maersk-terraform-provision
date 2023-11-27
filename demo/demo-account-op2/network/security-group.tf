locals {
  sg_config_name = "config/security-group.yaml"
  sg_config   = yamldecode(file("${path.module}/${local.sg_config_name}"))
}

module "security-group" {
  # source         = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-vpc"
  source         = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-security-group?ref=main"
  sg_config = try(local.sg_config, {})
}
