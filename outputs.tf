#-------VPC-------#
output "vpc_id" {
  value = aws_vpc.dev.id
}
output "vpc_cidr_block" {
  value = aws_vpc.dev.cidr_block
}

#-------Subnets-------#
output "public_subnet_ids" {
  value = [
    for k, s in aws_subnet.subnets :
    s.id if var.subnets[k].type == "public"
  ]
}
output "public_subnets" {
  value = [
    for k, s in aws_subnet.subnets :
    s.cidr_block if var.subnets[k].type == "public"
  ]
}
output "private_subnet_ids" {
  value = [
    for k, s in aws_subnet.subnets :
    s.id if var.subnets[k].type == "private"
  ]
}
output "private_subnets" {
  value = [
    for k, s in aws_subnet.subnets :
    s.cidr_block if var.subnets[k].type == "private"
  ]
}
