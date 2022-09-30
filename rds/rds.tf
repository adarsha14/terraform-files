resource "aws_db_instance" "myrds" {
	allocated_storage = 20
	engine		  = "mysql"
	engine_version    = "8.0.27"
	instance_class	  = "db.t2.micro"
	db_name		  = "mydb"
	username	  = "foo"
	password 	  = "foo123456"
	storage_type	  = "gp2"
	identifier	  = "rdstf"
	publicly_accessible = true
	skip_final_snapshot = true
	
	tags = {
		Name = "MyRDS"
	}
}
