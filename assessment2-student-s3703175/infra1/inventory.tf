data "template_file" "inventory_template" {
  template = file("../ansible/templates/inventory.tpl")
  vars = {
    host_instance = aws_instance.aws_instance.public_ip
    db_endpoint   = split(":", aws_db_instance.aws_database.endpoint)[0]
    db_name       = aws_db_instance.aws_database.name
    db_port       = aws_db_instance.aws_database.port
    db_username   = aws_db_instance.aws_database.username
    db_password   = aws_db_instance.aws_database.password
  }
}

resource "local_file" "inventory_file" {
  content  = data.template_file.inventory_template.rendered
  filename = "../ansible/inventory.yml"
}