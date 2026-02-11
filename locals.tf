locals {
  name_prefix = "dev"
  terraform_tag = "tf-made"
}

#-------Create Subnet IDs-------#
locals {
  public_subnet_ids = [
    for k, s in aws_subnet.subnets :
    s.id if var.subnets[k].type == "public"
  ]
  private_subnet_ids = [
    for k, s in aws_subnet.subnets :
    s.id if var.subnets[k].type == "private"
  ]
}

#-------Create Subnets-------#
locals {
  public_subnets = {
    for k, s in aws_subnet.subnets : k => s
    if var.subnets[k].type == "public"
  }
  private_subnets = {
    for k, s in aws_subnet.subnets : k => s
    if var.subnets[k].type == "private"
  }
}