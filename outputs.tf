output "vpn_instance_ip" {
  value = aws_instance.openvpn.public_ip
}

output "vpn_web_ui_url" {
  value = "https://${aws_instance.openvpn.public_ip}:943/admin"
}
