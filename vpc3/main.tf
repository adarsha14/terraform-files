locals {
	staging_env = "staging"
}
resource "aws_vpc" "staging-vpc" {
	cidr_block = "10.0.0.0/16"
	tags  = {
		Name = "${local.staging_env}-vpc-tag"
	}
}
resource "aws_subnet" "subnet" {
	vpc_id = aws_vpc.staging-vpc.id
	cidr_block = "10.0.1.0/24"
	tags = {
		Name = "${local.staging_env}-subnet-tag"
	}
}

resource "aws_security_group" "web_sg" {
  name   = "HTTP and SSH"
  vpc_id = aws_vpc.staging-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_internet_gateway" "some_ig" {
  vpc_id = aws_vpc.staging-vpc.id

  tags = {
    Name = "My Internet Gateway"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.staging-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.some_ig.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.some_ig.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_eip" "elasticIP" {
  instance = aws_instance.ec2.id
  vpc      = true
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.some_ig]
}
resource "aws_network_interface" "web-server-nic" {
	subnet_id = aws_subnet.subnet.id
	private_ips = ["10.0.1.50"]
	security_groups = [aws_security_group.web_sg.id]
}

resource "aws_instance" "ec2" {
	instance_type = "t2.micro"
        ami = "ami-05fa00d4c63e32376"
	key_name = "awskey2"
	network_interface {
		device_index = 0
		network_interface_id = aws_network_interface.web-server-nic.id
	}

	user_data = <<-EOF
	#!/bin/bash -ex

  	amazon-linux-extras install nginx1 -y
  	echo "<h1>My first web browser</h1>" >  /usr/share/nginx/html/index.html 
  	systemctl enable nginx
  	systemctl start nginx
  	EOF

	tags = {
                Name = "${local.staging_env}-instance-tag"
        }
}
output "server_private_ip" {
	value = aws_instance.ec2.private_ip
}
output "server_public_ip" {
	value = aws_eip.elasticIP.public_ip
}
