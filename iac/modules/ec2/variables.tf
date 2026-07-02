variable "sonarqube_instance_ami" {
    type        = string
    description = "ec2 ami"
}

variable "sonarqube_instance_type" {
    type        = string
    description = "ec2 instance type"
}

variable "sonarqube_vpc_id" {
    type        = string
    description = "sonarqube vpc"
}

variable "sonarqube_public_subnet_id" {
    type        = string
    description = "sonarqube public subnet id"
}
