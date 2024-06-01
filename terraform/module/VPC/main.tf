# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.VPC_CIDR
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.PROJECT_NAME}-vpc"
  }

}

# Find all the availability zone in particular region
data "aws_availability_zones" "available" {
  state = "available"
}

# Create subnet
resource "aws_subnet" "public01" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.PUB_SUB_1_A_CIDR
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "public01"
    # necessary tags for EKS controllers to identify Public subnet
    "kubernetes.io/cluster/${var.PROJECT_NAME}-eks-cluster" = "shared"
    "kubernetes.io/role/elb" = "1"
  }
}

# Create subnet
resource "aws_subnet" "public02" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.PUB_SUB_2_B_CIDR
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "public02"
    # necessary tags for EKS controllers to identify Public subnet
    "kubernetes.io/cluster/${var.PROJECT_NAME}-eks-cluster" = "shared"
    "kubernetes.io/role/elb" = "1"
  }
}
# Create subnet
resource "aws_subnet" "private01" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.PRI_SUB_3_A_CIDR
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "private01"
    # necessary tags for EKS controllers to identify Private subnet
    "kubernetes.io/cluster/${var.PROJECT_NAME}-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# Create subnet
resource "aws_subnet" "private02" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.PRI_SUB_4_B_CIDR
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "private02"
    # necessary tags for EKS controllers to identify Private subnet
    "kubernetes.io/cluster/${var.PROJECT_NAME}-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# Create Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.PROJECT_NAME}-igw"
  }
  depends_on = [aws_vpc.vpc]
}

# Create NAT gateway
resource "aws_eip" "nat_ip" {
  domain   = "vpc"
  depends_on = [aws_internet_gateway.igw]
}

# Create NAT gateway
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.public01.id

  tags = {
    Name = "${var.PROJECT_NAME}-nat-gw"
  }
  depends_on = [aws_internet_gateway.igw]
}

# Create Public RT
resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.PROJECT_NAME}-Public-RT"
  }
  depends_on = [aws_internet_gateway.igw]
}

# Create Private RT
resource "aws_route_table" "private-RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "${var.PROJECT_NAME}-Private-RT"
  }
   depends_on = [aws_nat_gateway.nat-gw]
}

resource "aws_route_table_association" "public01-public-RT" {
  subnet_id      = aws_subnet.public01.id
  route_table_id = aws_route_table.public-RT.id
}
resource "aws_route_table_association" "public02-public-RT" {
  subnet_id      = aws_subnet.public02.id
  route_table_id = aws_route_table.public-RT.id
}

resource "aws_route_table_association" "private01-private-RT" {
  subnet_id      = aws_subnet.private01.id
  route_table_id = aws_route_table.private-RT.id
}
resource "aws_route_table_association" "private02-private-RT" {
  subnet_id      = aws_subnet.private02.id
  route_table_id = aws_route_table.private-RT.id
}


