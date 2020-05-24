output "instance_public_ip" {
  value = aws_instance.aws_instance.public_ip
}

output "lb_endpoint" {
  value = aws_lb.aws_lb.dns_name
}

output "db_endpoint" {
  value = aws_db_instance.aws_database.endpoint
}

output "db_user" {
  value = aws_db_instance.aws_database.username
}

output "db_pass" {
  value = aws_db_instance.aws_database.password
}

output "db_name" {
  value = aws_db_instance.aws_database.name
}

output "db_port" {
  value = aws_db_instance.aws_database.port
}