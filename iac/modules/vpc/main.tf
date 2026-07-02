resource "aws_vpc" "sonarqube_vpc" {
  cidr_block            = "10.0.0.0/16"
  instance_tenancy      = "default"
  enable_dns_hostnames  = true

  tags              = {
    Name            = "sonarqube_vpc"
    Environment     = "dev"
    ManagedBy       = "terraform"
  }
}

resource "aws_subnet" "sonarqube_public_subnet" {
  vpc_id            = aws_vpc.sonarqube_vpc.id
  cidr_block        = "10.0.1.0/24"

  tags              = {
    Name            = "sonarqube_public_subnet"
    Environment     = "dev"
    ManagedBy       = "terraform"
  }
}

resource "aws_subnet" "sonarqube_private_subnet" {
  vpc_id            = aws_vpc.sonarqube_vpc.id
  cidr_block        = "10.0.2.0/24"

  tags              = {
    Name            = "sonarqube_private_subnet"
    Environment     = "dev"
    ManagedBy       = "terraform"
  }
}

resource "aws_internet_gateway" "sonarqube_ig" {
  vpc_id            = aws_vpc.sonarqube_vpc.id

  tags              = {
    Name            = "sonarqube_ig"
    Environment     = "dev"
    ManagedBy       = "terraform"
  }
}

resource "aws_route_table" "sonarqube_public_rt" {
  vpc_id            = aws_vpc.sonarqube_vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.sonarqube_ig.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.sonarqube_ig.id
  }

  tags              = {
    Name            = "sonarqube_public_rt"
    Environment     = "dev"
    ManagedBy       = "terraform"
  }
}

resource "aws_route_table_association" "sonarqube_public_rt_a" {
  subnet_id         = aws_subnet.sonarqube_public_subnet.id
  route_table_id    = aws_route_table.sonarqube_public_rt.id
}
