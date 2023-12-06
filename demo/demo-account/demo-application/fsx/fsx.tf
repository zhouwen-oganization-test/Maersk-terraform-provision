locals {
  fsx_config_name     = "config/fsx.yaml"
  fsx_config = yamldecode(file("${path.module}/${local.fsx_config_name}"))
}

variable "fsx_admin_password" {
  description = "get password from github environment secrets"
  default = ""
}

module "fsx-instances" {
  # source                    = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-fsx-ontap"
  source                    = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-fsx-ontap?ref=main"
  fsx_config           = local.fsx_config
  fsx_admin_password   = var.fsx_admin_password
}
