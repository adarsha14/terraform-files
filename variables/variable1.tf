resource "aws_instance" "ec2_example" {
	ami = var.ami
	instance_type = var.instance_type
	count = var.count1
	associate_public_ip_address = var.pub_ip

	tags = var.project_env
}
variable "instance_type" {
	type = string
	default = "t2.micro"
}
variable "ami" {
        description = "type of ami"
        type = string
        default = "ami-05fa00d4c63e32376"
}
variable "count1" {
        type = number
        default = 1
	description = "count"
}
variable "pub_ip" {
        type = bool
        default = true
        description = "count"
}


variable "project_env" {
        type = map(string)
        default = {
		project = "Project-alpha",
		environment = "dev"
	}
}




resource "aws_iam_user" "example" {
        count = length(var.user_name)
        name = var.user_name[count.index]
}
variable "user_name" {
        type = list(string)
        default = ["user1", "user2", "user3"]
}












