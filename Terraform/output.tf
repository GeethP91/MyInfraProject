output "PublicIP" {
  value = "aws_instance.Web_Instance.public_ip"
}

output "ssh" {
  value = "ssh ${local.ec2_user}@${aws_instance.Web_Instance.public_ip}"
}
