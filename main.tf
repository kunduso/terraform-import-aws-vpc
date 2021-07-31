resource "aws_vpc" "this_vpc" {
  cidr_block       = var.vpc_address_space
  instance_tenancy = "default"
    tags = {
    Name = "primary"
  }
}
data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_subnet" "public_subnet" {
  count                   = length(var.subnet_address_space)
  cidr_block              = var.subnet_address_space[count.index]
  vpc_id                  = aws_vpc.this_vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
    tags = {
      Name = "public_subnet_${count.index + 1}"
    }
}
resource "aws_internet_gateway" "this_gateway" {
  vpc_id = aws_vpc.this_vpc.id
  tags = {
    "Name" = "primary_gateway"
  }
}

resource "aws_route_table" "this_route_table" {
  vpc_id = aws_vpc.this_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this_gateway.id
  }
  tags = {
    "Name" = "primary_route_table"
  }
}

resource "aws_route_table_association" "public-rta" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.this_route_table.id

}