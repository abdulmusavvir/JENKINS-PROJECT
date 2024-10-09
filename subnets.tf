resource "aws_subnet" "public_subnets" {
  count                   = var.public_subnets_counts
  vpc_id                  = aws_vpc.default-vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name   = "public_${cidrsubnet(var.cidr_block, 8, count.index)}.0_${element(var.availability_zone, count.index)}"
    Author = var.author
  }
  depends_on = [aws_vpc.default-vpc]
}

resource "aws_subnet" "private_subnets" {
  count  = var.private_subnets_counts
  vpc_id = aws_vpc.default-vpc.id
  # cidrsubnet(10.0.0.0/16,8,0) --> 10.0.2.0/24, second will be 10.0.3.0/24 and so on
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index + 2)
  # availability_zone = element(us-east-1a,us-east-1b,us-east-1c,0 )--> us-east-1a,us-east-1b because teh count is 2 to do baar chalega
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name   = "private_${cidrsubnet(var.cidr_block, 8, count.index + 2)}.0_${element(var.availability_zone, count.index)}"
    Author = var.author
  }
  depends_on = [aws_vpc.default-vpc]
}