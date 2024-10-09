resource "aws_internet_gateway" "igw" {
  tags = {
    Name   = "igw_${var.vpc_name}"
    Author = var.author
  }
  vpc_id = aws_vpc.default-vpc.id
}



resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.default-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name   = "public_rt_${var.vpc_name}"
    Author = var.author
  }
}


resource "aws_route_table_association" "public" {
  count          = var.public_subnets_counts
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}