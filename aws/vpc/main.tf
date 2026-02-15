/**
 * VPC with public and private subnets, IGW, optional NAT gateway.
 * Reference: modules-clone/terraform-aws-vpc (simplified, no internal modules).
 */

locals {
  num_public  = max(length(var.public_subnets), length(var.azs))
  num_private = max(length(var.private_subnets), length(var.azs))
  nat_count   = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : local.num_public) : 0
  num_priv_rt = local.num_private > 0 ? (var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : local.nat_count) : 1) : 0
}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(var.tags, { "Name" = var.name })
}

resource "aws_subnet" "public" {
  count = local.num_public

  vpc_id                  = aws_vpc.this.id
  cidr_block              = length(var.public_subnets) > 0 ? element(var.public_subnets, count.index) : cidrsubnet(var.cidr, 4, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(var.tags, { "Name" = "${var.name}-public-${element(var.azs, count.index)}" })
}

resource "aws_subnet" "private" {
  count = local.num_private

  vpc_id            = aws_vpc.this.id
  cidr_block        = length(var.private_subnets) > 0 ? element(var.private_subnets, count.index) : cidrsubnet(var.cidr, 4, count.index + 16)
  availability_zone = element(var.azs, count.index)

  tags = merge(var.tags, { "Name" = "${var.name}-private-${element(var.azs, count.index)}" })
}

resource "aws_internet_gateway" "this" {
  count = local.num_public > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, { "Name" = var.name })
}

resource "aws_route_table" "public" {
  count = local.num_public > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, { "Name" = "${var.name}-public" })
}

resource "aws_route" "public_igw" {
  count = local.num_public > 0 ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
}

resource "aws_route_table_association" "public" {
  count = local.num_public

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id
}

resource "aws_eip" "nat" {
  count = local.nat_count

  domain = "vpc"
  tags   = merge(var.tags, { "Name" = "${var.name}-nat-${count.index + 1}" })

  depends_on = [aws_internet_gateway.this]
}

resource "aws_nat_gateway" "this" {
  count = local.nat_count

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[var.single_nat_gateway ? 0 : count.index].id

  tags = merge(var.tags, { "Name" = "${var.name}-nat-${count.index + 1}" })

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route_table" "private" {
  count = local.num_priv_rt

  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, { "Name" = "${var.name}-private-${count.index + 1}" })
}

resource "aws_route" "private_nat" {
  count = var.enable_nat_gateway && local.num_priv_rt > 0 ? local.num_priv_rt : 0

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[count.index].id
}

resource "aws_route_table_association" "private" {
  count = local.num_private

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[var.single_nat_gateway || local.nat_count == 0 ? 0 : (count.index % local.nat_count)].id
}
