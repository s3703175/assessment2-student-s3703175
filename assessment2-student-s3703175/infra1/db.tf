resource "aws_db_instance" "aws_database" {
  instance_class         = "db.t2.micro"
  db_subnet_group_name   = aws_db_subnet_group.aws_db_subnet_group.name
  vpc_security_group_ids = [aws_vpc.aws_vpc.default_security_group_id]
  allocated_storage      = 8
  engine                 = "postgres"
  engine_version         = "9.6.16"
  username               = "admin"
  password               = "admin123"
  name                   = "awsdatabase"
  identifier             = "awsdatabase"
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "aws_db_subnet_group" {
  name       = "my_db_subnet_group"
  subnet_ids = [aws_subnet.D01.id, aws_subnet.D02.id, aws_subnet.D03.id]

  tags = {
    Name = "aws_db_subnet_group"
  }
}