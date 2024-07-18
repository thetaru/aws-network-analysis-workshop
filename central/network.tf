# VPC
resource "aws_vpc" "Central_Egress_VPC" { 
  cidr_block = "10.10.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Central Egress VPC"
  }
}

# Subnet
resource "aws_subnet" "Central_Egress_TGW_Subnet" {
  vpc_id            = aws_vpc.Central_Egress_VPC.id
  cidr_block        = "10.10.0.0/28"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "Central Egress TGW Subnet"
  }
}

resource "aws_subnet" "Central_Egress_Public_Subnet" {
  vpc_id                  = aws_vpc.Central_Egress_VPC.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Central Egress Public Subnet"
  }
}

# Route Table
resource "aws_route_table" "Central_Egress_TGW_Subnet_Route_Table" {
  vpc_id = aws_vpc.Central_Egress_VPC.id

  # route {}

  tags = {
    Name = "Central Egress TGW Subnet Route Table"
  }
}

resource "aws_route_table" "Central_Egress_Public_Subnet_Route_Table" {
  vpc_id = aws_vpc.Central_Egress_VPC.id

  # route {}

  tags = {
    Name = "Central Egress Public Subnet Route Table"
  }
}

# Route Table Association
resource "aws_route_table_association" "Central_Egress_TGW_Route_Table_Association" {
  subnet_id      = aws_subnet.Central_Egress_TGW_Subnet.id
  route_table_id = aws_route_table.Central_Egress_TGW_Subnet_Route_Table.id
}

resource "aws_route_table_association" "Central_Egress_Public_Route_Table_Association" {
  subnet_id      = aws_subnet.Central_Egress_Public_Subnet.id
  route_table_id = aws_route_table.Central_Egress_Public_Subnet_Route_Table.id
}

# Internet Gateway
resource "aws_internet_gateway" "Central_Egress_IGW" {
  vpc_id = aws_vpc.Central_Egress_VPC.id

  tags = {
    Name = "Central Egress IGW"
  }
}

# Nat Gateway
resource "aws_eip" "Central_Egress_NATGW_EIP" {
  domain = "vpc"
}

resource "aws_nat_gateway" "Central_Egress_NATGW" {
  allocation_id = aws_eip.Central_Egress_NATGW_EIP.id
  subnet_id     = aws_subnet.Central_Egress_Public_Subnet.id

  tags = {
    Name = "Central Egress NATGW"
  }

  depends_on = [aws_internet_gateway.Central_Egress_IGW]
}
