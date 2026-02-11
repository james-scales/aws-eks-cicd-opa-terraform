resource "aws_subnet" "subnets" {
for_each = var.subnets

  vpc_id                  = aws_vpc.dev.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.type == "public" ? true : false

  tags = {
    Name = "${local.name_prefix}-${each.value.type}-subnet"
    Type = each.value.type
  }
}