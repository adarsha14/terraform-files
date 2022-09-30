variable "user_name" {
	type = set(string)
	default = ["user1", "user2", "user3"]
}
resource "aws_iam_user" "iam" {
	for_each = var.user_name
	name = each.value
}

