# VPC
resource "aws_vpc" "Prod_VPC" { 
  cidr_block = "10.1.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Prod VPC"
  }
}

# Subnet
resource "aws_subnet" "Prod_TGW_Subnet" {
  vpc_id            = aws_vpc.Prod_VPC.id
  cidr_block        = "10.1.0.0/28"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "Prod TGW Subnet"
  }
}

resource "aws_subnet" "Prod_Workload_Subnet" {
  vpc_id            = aws_vpc.Prod_VPC.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "Prod Workload Subnet"
  }
}

resource "aws_subnet" "Prod_Database_Subnet1" {
  vpc_id            = aws_vpc.Prod_VPC.id
  cidr_block        = "10.1.0.16/28"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "Prod Database Subnet1"
  }
}

resource "aws_subnet" "Prod_Database_Subnet2" {
  vpc_id            = aws_vpc.Prod_VPC.id
  cidr_block        = "10.1.0.32/28"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "Prod Database Subnet2"
  }
}
# Route Table
resource "aws_route_table" "Prod_Route_Table" {
  vpc_id = aws_vpc.Prod_VPC.id

  # route {}

  tags = {
    Name = "Prod Route Table"
  }
}

# Route Table Association
resource "aws_route_table_association" "Prod_TGW_Route_Table_Association" {
  subnet_id      = aws_subnet.Prod_TGW_Subnet.id
  route_table_id = aws_route_table.Prod_Route_Table.id
}

resource "aws_route_table_association" "Prod_Workload_Route_Table_Association" {
  subnet_id      = aws_subnet.Prod_Workload_Subnet.id
  route_table_id = aws_route_table.Prod_Route_Table.id
}
