locals {
  sns_config_name     = "config/sns.yaml"
  local_sns_config = yamldecode(file("${path.module}/${local.sns_config_name}"))
  #ec2_templates_config    = { for t in try(local.sns_config.templates, []) : t.name => t }
}

module "sns_topic_new" {
  # source                    = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-ec2"
  #for_each  = { for t in local.sns_config.topics : t.name => t }
  sns_config = local.local_sns_config
  #source     = "/Users/wajiawei/Project/Maersk-China-New-LZ/IaC/Maersk-org-terraform-modules/terraform-modules-sns"
  source         = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-sns?ref=main"
  ocf_ou_id  = "o-5f4rsudtpl"
}
