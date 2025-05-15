#Create Subnet Group
resource "aws_db_subnet_group" "db-group-terra" {
  name = "dbg-terra"
  subnet_ids = [ aws_subnet.subnet-private-1a.id, aws_subnet.subnet-private-2b.id ]

  tags = {
    Name = "Dbg-tera"
  }
}

#Create RDS Instance
resource "aws_db_instance" "rds-terra" {
  identifier = "rds-terra"

  engine = "mysql"
  engine_version = "8.0.41"
  instance_class = "db.t3.micro"
  allocated_storage = 20

  db_name = "terra_db"
  username = "adminterra"
  password = "terraP0rt"

  db_subnet_group_name = aws_db_subnet_group.db-group-terra.id
  vpc_security_group_ids = [aws_security_group.sg-db.id]
  
  multi_az = false
  publicly_accessible = false
  parameter_group_name = "default.mysql8.0"
  
  skip_final_snapshot = true
  storage_encrypted = true
}