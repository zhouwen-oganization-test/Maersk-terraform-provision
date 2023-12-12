locals {
  opensearch_config_name     = "config/opensearch.yaml"
  opensearch_config = yamldecode(file("${path.module}/${local.opensearch_config_name}"))
}

variable "master_user_password" {
  description = "get password from github environment secrets"
  default = ""
}

module "opensearch-instances" {
  # source                    = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-fsx-ontap"
  #source     = "/Users/wajiawei/Project/Maersk-China-New-LZ/IaC/Maersk-org-terraform-modules/terraform-modules-opensearch"
  source                    = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-opensearch?ref=main"
  opensearch_config           = local.opensearch_config
  master_user_password   = var.master_user_password
}
