locals {
  sqs_config_name     = "config/sqs.yaml"
  local_sqs_config = yamldecode(file("${path.module}/${local.sqs_config_name}"))
}

module "sqs_queue_new" {
  # source                    = "/Users/zhouwenh/Desktop/maersk/maersk-code/Maersk-org-terraform-modules/terraform-modules-ec2"
  #for_each  = { for t in local.sns_config.topics : t.name => t }
  sqs_config = local.local_sqs_config
  #source     = "/Users/wajiawei/Project/Maersk-China-New-LZ/IaC/Maersk-org-terraform-modules/terraform-modules-sqs"
  source         = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-modules-sqs?ref=main"
  ocf_ou_id  = "o-5f4rsudtpl"
}
