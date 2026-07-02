output "sonarqube_vpc_id" {
    description = "sonarqube vpc id"
    value       = aws_vpc.sonarqube_vpc.id
}

output "sonarqube_public_subnet_id" {
    description = "sonarqube public subnet id"
    value       = aws_subnet.sonarqube_public_subnet.id
}
