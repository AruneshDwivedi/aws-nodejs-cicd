output "app_public_ip" {
  description = "Public IP of Node.js app server"
  value       = aws_instance.app_server.public_ip
}
