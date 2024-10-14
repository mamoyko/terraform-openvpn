# Define VPC
resource "aws_vpc" "vpn_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "OpenVPN VPC"
  }
}

# Define Subnet
resource "aws_subnet" "vpn_subnet" {
  vpc_id     = aws_vpc.vpn_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "OpenVPN Subnet"
  }
}

# Create Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "vpn_igw" {
  vpc_id = aws_vpc.vpn_vpc.id
  tags = {
    Name = "OpenVPN Internet Gateway"
  }
}

# Create a Route Table for the VPC and add an internet route
resource "aws_route_table" "vpn_route_table" {
  vpc_id = aws_vpc.vpn_vpc.id
  tags = {
    Name = "OpenVPN Route Table"
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "vpn_subnet_association" {
  subnet_id      = aws_subnet.vpn_subnet.id
  route_table_id = aws_route_table.vpn_route_table.id
}

# Create a route for Internet traffic (0.0.0.0/0)
resource "aws_route" "vpn_internet_route" {
  route_table_id         = aws_route_table.vpn_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpn_igw.id
}
