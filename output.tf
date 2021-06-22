output "MySQL_server_public_ip" {
    value = aws_eip.static_sql.public_ip
}
output "TomCat_server_public_ip" {
    value = aws_eip.static_tom.public_ip
}
