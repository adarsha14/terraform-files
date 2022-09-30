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
        ami = "ami-05fa00d4c63e32376"
        instance_type = "t2.medium"
        vpc_security_group_ids = ["launch-wizard-4"]
        availability_zone = "us-east-1c"
        user_data = file("ansible.sh")
        key_name = "awskey2"

	root_block_device {
           volume_size  = 30
        }

        tags = {
                Name = "Pansible"
        }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2_variable.id
  allocation_id = aws_eip.example.id
}


resource "aws_eip" "example" {
  vpc = true
}

