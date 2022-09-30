resource "aws_instance" "new" {
	ami = "ami-05fa00d4c63e32376"
	instance_type = var.instance_type
	tags = {
		Name = "new instance1"
	}

}
# terraform apply -var="instance_type=t2.micro"
