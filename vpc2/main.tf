resource "aws_instance" "ec2_example" {
	instance_type = "t2.micro"
	ami = "ami-05fa00d4c63e32376"
	tags={
		Name = "Output_instance"
	}
}
output "my_console_output" {
		value = aws_instance.ec2_example.public_ip
}
