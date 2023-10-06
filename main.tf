module "vpc" {
  source = "git::https://github.com/jayadeep2702/tf-module-vpc.git"
  for_each = var.vpc
  subnets = each.value["subnets"]
  cidr_block = each.value["cidr_block"]
  tags = local.tags
  env = var.env


}