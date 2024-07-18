# VPC
resource "aws_vpc" "Inspection_VPC" { 
  cidr_block = "100.64.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Inspection VPC"
  }
}

# Subnet
resource "aws_subnet" "Inspection_TGW_Subnet" {
  vpc_id            = aws_vpc.Inspection_VPC.id
  cidr_block        = "100.64.0.0/28"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "Inspection TGW Subnet"
  }
}

resource "aws_subnet" "Inspection_Firewall_Subnet" {
  vpc_id            = aws_vpc.Inspection_VPC.id
  cidr_block        = "100.64.0.16/28"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "Inspection Firewall Subnet"
  }
}

# Route Table
resource "aws_route_table" "Inspection_TGW_Subnet_Route_Table" {
  vpc_id = aws_vpc.Inspection_VPC.id

  # route {}

  tags = {
    Name = "Inspection TGW Subnet Route Table"
  }
}

resource "aws_route_table" "Inspection_Firewall_Subnet_Route_Table" {
  vpc_id = aws_vpc.Inspection_VPC.id

  # route {}

  tags = {
    Name = "Inspection TGW Subnet Route Table"
  }
}

# Route Table Association
resource "aws_route_table_association" "Inspection_TGW_Route_Table_Association" {
  subnet_id      = aws_subnet.Inspection_TGW_Subnet.id
  route_table_id = aws_route_table.Inspection_TGW_Subnet_Route_Table.id
}

resource "aws_route_table_association" "Inspection_Firewall_Route_Table_Association" {
  subnet_id      = aws_subnet.Inspection_Firewall_Subnet.id
  route_table_id = aws_route_table.Inspection_Firewall_Subnet_Route_Table.id
}
