resource "aws_instance" "ec2_example" {
	ami = "ami-05fa00d4c63e32376"
	instance_type = var.instance_type

	tags = {
		name = var.environment_name
	}
}
