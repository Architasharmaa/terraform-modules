# resource"aws_db_instance" "myrds"{
#     engine ="mysql"
#     engine_version= "8.0.35"
#     allocated_storage= "20"
#     storage_type ="gp2"
#     identifier = "mydb"
#     username = "admin"
#     password = "passwOrd!123"
#     publicly_accessible = true
#     skip_final_snapshot = true
#     instance_class = "db.t3.micro"
#     tags={
#         Name = "Myrdsb"
#     }

# }
# resource "null_resource" "create_table" {
#   triggers = {
#     instance_id = aws_db_instance.myrds.id
#   }

#   provisioner "local-exec" {
#     command = "mysql -h ${aws_db_instance.myrds.endpoint} -u admin -p${myrds.password} < path/to/create_table.sql"
#   }
# }
# Define the RDS instance
resource "aws_db_instance" "myrds1" {
    engine               = "mysql"
    engine_version       = "8.0.35"
    allocated_storage    = 20
    storage_type         = "gp2"
    identifier           = "mydb"
    username             = "admin"
    password             = "passwOrd!123"
    publicly_accessible = true
    skip_final_snapshot = true
    instance_class       = "db.t3.micro"
    tags = {
        Name = "Myrdsb1"
    }
}

# Execute SQL script to create a table
resource "null_resource" "create_table" {
    depends_on = [aws_db_instance.myrds1]
    triggers = {
      instance_id=aws_db_instance.myrds1.id
    }
    provisioner "local-exec" {
        command = "mysql -h ${aws_db_instance.myrds1.endpoint} -u ${aws_db_instance.myrds1.username} -p${aws_db_instance.myrds1.password}/../table.sql"
    }
}
