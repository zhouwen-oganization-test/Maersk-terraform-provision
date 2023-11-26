locals {
  vpc_config_name = "config/vpc.yaml"
  vpc_config   = yamldecode(file("${path.module}/${local.vpc_config_name}"))
}

module "vpc" {
  # source         = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-vpc"
  source         = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-vpc?ref=main"
  vpc_config = try(local.vpc_config, {})
}
output "account_vpc_module" {
  value = local.module.vpcs
}
