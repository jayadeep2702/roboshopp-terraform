module "vpc" {
  source = "git::https://github.com/jayadeep2702/tf-module-vpc.git"
  for_each = var.vpc
  subnets = each.value["subnets"]
  cidr_block = each.value["cidr_block"]
  tags = local.tags
  env = var.env


}

module "web" {
  source = "git::https://github.com/jayadeep2702/tf-module-app.git"
  for_each = var.app
  instance_type = each.value["instance_type"]
  subnet_name =element(lookup(lookup(lookup(lookup(module.vpc,"main", null ), "subnets", null), each.value["subnet_name"], null), "subnet_ids", null), 0)
}