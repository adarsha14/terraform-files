terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}
provider "aws" {
	region = "us-east-1"
}
resource "aws_instance" "ec2_variable" {
	ami = "ami-08d4ac5b634553e16"
	instance_type = "t2.micro"
	vpc_security_group_ids = ["launch-wizard-4"]
	availability_zone = "us-east-1c"
	user_data = file("docker.sh")
	key_name = "awskey2"
	tags = {
		Name = "Ubuntu-Docker"
	}
}
output "instance_ip_addr" {
  value = aws_instance.ec2_variable.public_ip
}
