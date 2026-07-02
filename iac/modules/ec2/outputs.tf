output "sonarqube_ec2_public_dns" {
    description = "sonarqube ec2 public dns value"
    value       = aws_instance.sonarqube_ec2.public_dns
}
