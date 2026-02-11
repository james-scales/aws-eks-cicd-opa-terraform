resource "aws_eip" "nat_eip" {
  # vpc = true

  tags = {
    Name      = "${local.name_prefix}-nat-eip"
    Terraform = local.terraform_tag
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = local.public_subnet_ids[0]

  tags = {
    Name      = "${local.name_prefix}-nat-gateway"
    Terraform = local.terraform_tag
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name      = "${local.name_prefix}-igw"
    Terraform = local.terraform_tag
  }
}