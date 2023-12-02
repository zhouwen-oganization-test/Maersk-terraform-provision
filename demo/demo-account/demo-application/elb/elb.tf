locals {
  lb_config_name     = "config/elb.yaml"
  lb_config = yamldecode(file("${path.module}/${local.lb_config_name}"))
}

module "lb_instances" {
  # source                    = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-elb"
  source                    = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-elb?ref=main"
  lb_config           = local.lb_config
}
