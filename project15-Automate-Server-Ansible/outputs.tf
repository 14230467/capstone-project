output "controller_public_ip" {
  value = aws_instance.controller.public_ip
}

output "managed_node_public_ip" {
  value = aws_instance.managed_node.public_ip
}

output "web_server_url" {
  value = "http://${aws_instance.managed_node.public_ip}"
}