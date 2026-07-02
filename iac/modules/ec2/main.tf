resource "aws_instance" "sonarqube_ec2" {
  ami                         = var.sonarqube_instance_ami
  instance_type               = var.sonarqube_instance_type
  vpc_security_group_ids      = [aws_security_group.sonarqube_sg.id]
  subnet_id                   = var.sonarqube_public_subnet_id
  associate_public_ip_address = true
  user_data                   = file("./scripts/user_data.sh")

  tags                        = {
    Name                      = "sonarqube_ec2"
    Environment               = "dev"
    ManagedBy                 = "terraform"
  }
}

resource "aws_security_group" "sonarqube_sg" {
  name            = "sonarqube_sg"
  description     = "security group allowing ec2 access"
  vpc_id          = var.sonarqube_vpc_id

  tags            = {
    Name          = "sonarqube_sg"
    Environment   = "dev"
    ManagedBy     = "terraform"
  }
}

resource "aws_security_group_rule" "rule_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sonarqube_sg.id
}

resource "aws_security_group_rule" "rule_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sonarqube_sg.id
}

resource "aws_security_group_rule" "rule_in_sonar" {
  type              = "ingress"
  from_port         = 9000
  to_port           = 9000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sonarqube_sg.id
}

resource "aws_security_group_rule" "rule_out_http" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sonarqube_sg.id
}
