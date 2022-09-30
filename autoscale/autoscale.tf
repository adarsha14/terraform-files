resource "aws_launch_template" "auto_scale" {
	name_prefix = "auto_scale"
	image_id = "ami-05fa004c63e32376"
	instance_type = "t2.micro"
}
resource "aws_autoscaling_group" "bar" {
	availability_zones = ["us-east-1c"]
	max_size = 5
	min_size = 1
	desired_capacity = 1
	launch_template {
		id = aws_launch_template.auto_scale.id
		version = "$Latest"
	}
}
