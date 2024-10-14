# Allocate an Elastic IP for the OpenVPN server
resource "aws_eip" "vpn_eip" {
  instance = aws_instance.openvpn.id
}

# EC2 Instance for OpenVPN Server
resource "aws_instance" "openvpn" {
  ami           = "ami-0a89e5734746d19eb"  # Your OpenVPN Access Server AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.vpn_subnet.id
  vpc_security_group_ids = [aws_security_group.openvpn_sg.id]

  associate_public_ip_address = true

  # Reference to the key pair name
  key_name = "open-vpn"  # Make sure you have this key pair in AWS

  tags = {
    Name = "OpenVPN Access Server"
  }
}
