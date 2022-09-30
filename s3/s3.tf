resource "aws_s3_bucket" "bucket" {
	acl = "public-read"
	
	versioning {
		enabled = true
	}
}

#resource "aws_s3_bucket_object" "object" {
#	bucket = aws_s3_bucket.bucket.id
#	key = "sample.txt"
#	source = "/root/s3/sample.txt"
#}

resource "aws_s3_bucket_object" "test" {
	for_each = fileset(path.module,"**")
	bucket = aws_s3_bucket.bucket.id
	key = each.value
	source = "/root/foreach/"
}
output "fileset-result" {
	value = fileset(path.module, "**")
}
