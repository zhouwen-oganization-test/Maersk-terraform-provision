locals {
  s3_config_name = "config/s3.yaml"
  s3_config      = yamldecode(file("${path.module}/${local.s3_config_name}"))
}

module "s3_buckets" {
  source    = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-s3?ref=main"
  s3_config = local.s3_config
}
