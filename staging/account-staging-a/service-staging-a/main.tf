module "ec2_instance" {
  source  = "git::https://github.com/zhouwen-oganization-test/Maersk-org-terraform-modules.git//terraform-aws-ec2-instance?ref=main"

  name = "staging-a-service-a-prototype-instances"

  ami                    = "ami-0b0f138edf421d756"
  instance_type          = "t3.micro"
  monitoring             = false 

  tags = {
    Terraform   = "true"
    Environment = "staging"
    TestNo      = "test tag 2"
  }
}