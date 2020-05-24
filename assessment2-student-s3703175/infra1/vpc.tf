resource "aws_vpc" "aws_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "aws_vpc"
  }
}

resource "aws_internet_gateway" "aws_ig" {
  vpc_id = aws_vpc.aws_vpc.id

  tags = {
    Name = "aws_ig"
  }
}


resource "aws_default_security_group" "my_vpc_sg" {
  vpc_id = aws_vpc.aws_vpc.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  ingress {
    description = "PGSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_default_route_table" "aws_default_r" {
  default_route_table_id = aws_vpc.aws_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_ig.id
  }

  tags = {
    Name = "aws_default_r"
  }
}

resource "aws_subnet" "pu01" {
  cidr_block              = "10.0.0.0/22"
  vpc_id                  = aws_vpc.aws_vpc.id
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PU01"
  }
}

resource "aws_subnet" "pu02" {
  cidr_block              = "10.0.4.0/22"
  vpc_id                  = aws_vpc.aws_vpc.id
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "PU02"
  }
}

resource "aws_subnet" "pu03" {
  cidr_block              = "10.0.8.0/22"
  vpc_id                  = aws_vpc.aws_vpc.id
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "PU03"
  }
}

resource "aws_subnet" "pr01" {
  cidr_block              = "10.0.12.0/22"
  vpc_id                  = aws_vpc.aws_vpc.id
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PR01"
  }
}

resource "aws_subnet" "pr02" {
  cidr_block              = "10.0.16.0/22"
  vpc_id                  = aws_vpc.aws_vpc.id
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "PR02"
  }
}

resource "aws_subnet" "PR03" {
  cidr_block              = "10.0.20.0/22"
  vpc_id                  = aws_vpc.aws_vpc.id
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "PR03"
  }
}

resource "aws_subnet" "D01" {
  cidr_block              = "10.0.24.0/22"
  vpc_id                  = aws_vpc.aws_vpc.id
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "D01"
  }
}

resource "aws_subnet" "D02" {
  cidr_block              = "10.0.28.0/22"
  vpc_id                  = aws_vpc.aws_vpc.id
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "D02"
  }
}

resource "aws_subnet" "D03" {
  cidr_block              = "10.0.32.0/22"
  vpc_id                  = aws_vpc.aws_vpc.id
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "D03"
  }
}