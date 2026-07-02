variable "sonarqube_instance_ami" {
    type        = string
    description = "ec2 ami"
    default     = "ami-0a02a779008fa3b99"
}

variable "sonarqube_instance_type" {
    type        = string
    description = "ec2 instance type"
    default     = "t2.medium"
}
