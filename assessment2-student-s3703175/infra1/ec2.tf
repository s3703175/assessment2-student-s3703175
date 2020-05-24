resource "aws_instance" "aws_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.aws_key_pair.key_name
  subnet_id                   = aws_subnet.pr01.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.aws_security_group.id]

  tags = {
    Name = "aws_instance"
  }
}

resource "aws_security_group" "aws_security_group" {
  description = "Allow HTTP & SSH inbound traffic"
  name        = "my_security_group"
  vpc_id      = aws_vpc.aws_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "PGSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
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

resource "aws_lb" "aws_lb" {
  name               = "aws-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.aws_security_group.id]
  subnets            = [aws_subnet.pu01.id, aws_subnet.pu02.id, aws_subnet.pu03.id]

}

resource "aws_lb_target_group" "aws_lb_target_group" {
  name     = "aws-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.aws_vpc.id
}

resource "aws_lb_listener" "my_loadbalancer_listener" {
  load_balancer_arn = aws_lb.aws_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_lb_target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "my_loadbalancer_attachment" {
  target_group_arn = aws_lb_target_group.aws_lb_target_group.arn
  target_id        = aws_instance.aws_instance.id
  port             = 3000
}

