locals {
  vpc_config_name = "config/VPC.yaml"
  vpc_yaml_vars   = yamldecode(file("${path.module}/${local.vpc_config_name}"))
}

# locals {
#   region        = try(local.vpc_yaml_vars.global.region, "")
#   tags          = merge({
#     "TerraformManaged" = true
#   },
#   can(local.vpc_yaml_vars.global.project_name) ?
#    { "Project" = local.vpc_yaml_vars.global.project_name } : {},
#    try(local.vpc_yaml_vars.global.tags, {})
#   )
# }

locals {
  vpc_config = { for a in local.vpc_yaml_vars.accounts : a.account_alias => a }
  account_vpc_module = {

    "PRD-APP" = module.VPC

  }
}

data "aws_partition" "this" {}
data "aws_caller_identity" "this" {}
data "aws_region" "this" {}

module "VPC" {
  # source         = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-vpc-demo"
  source         = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-vpc-demo?ref=main"
  account_config = try(local.vpc_config["PRD-APP"], {})
}
output "account_vpc_module" {
  value = local.account_vpc_module
}
