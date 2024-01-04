locals {
  log_group_name   = "config/cloudwatch-log-group.yaml"
  log_group_config = yamldecode(file("${path.module}/${local.log_group_name}"))
}

module "log_groups" {
  source    = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-cloudwatch-log-group?ref=main"
  log_group_config = try(local.log_group_config, {})
}