
resource "aws_instance" "ec2-instance-vpn" {
  ami              = var.ec2_AMI
  instance_type    = var.ec2_instance_type
  key_name         = var.ec2_key_name
  user_data_base64 = base64encode(local.userdata)
  tags = {
    Name    = "vpn-gate"
    cluster = "vpn-gate"
  }
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.ec2-emi-vpn.id
  }
}

resource "aws_network_interface" "ec2-emi-vpn" {
  subnet_id         = aws_subnet.ec2_public_sn_01.id
  private_ips       = [var.ec21_private_ip]
  security_groups   = [aws_security_group.ec2_VPN.id]
  source_dest_check = false
}

resource "aws_eip" "aws-eip-vpn" {
  vpc                       = true
  network_interface         = aws_network_interface.ec2-emi-vpn.id
  associate_with_private_ip = var.ec21_private_ip
  depends_on                = [aws_internet_gateway.ec2IG]

}

output "public_address" {
  value = aws_eip.aws-eip-vpn.public_ip
}