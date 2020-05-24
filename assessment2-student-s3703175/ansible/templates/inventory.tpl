all:
  hosts:
    ${host_instance}
  vars:
    endpoint: ${db_endpoint}
    name: ${db_name}
    port: ${db_port}
    username: ${db_username}
    password: ${db_password}