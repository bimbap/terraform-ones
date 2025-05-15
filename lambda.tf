#Function Delete
resource "aws_lambda_function" "lambda-lks-delete" {
  function_name = "lks-delete"
  role = "arn:aws:iam::781564733297:role/LabRole"
  handler = "index.handler"
  runtime = "python3.13"

  #Up Zip dari lokal directory
    filename         = "${path.module}/lambda/lks_delete/lks_delete.zip"
    source_code_hash = filebase64sha256("${path.module}/lambda/lks_delete/lks_delete.zip")

  #Env
  environment {
    variables = {
        DB_HOST = "rds-terra.cwtv1hoknkdd.us-east-1.rds.amazonaws.com"
        DB_PORT = 3306
        DB_USER = "adminterra"
        DB_PASSWORD = "terraP0rt"
        DB_NAME = "terra_db"
    }
  }

  vpc_config {
    subnet_ids = [aws_subnet.subnet-private-1a.id, aws_subnet.subnet-private-2b.id]
    security_group_ids = [ aws_security_group.sg-apps.id, aws_security_group.sg-lb.id ]
  }
}

#Function Get
resource "aws_lambda_function" "lambda-lks-get" {
  function_name = "lks-get"
  role = "arn:aws:iam::781564733297:role/LabRole"
  handler = "index.handler"
  runtime = "python3.13"

  #Up Zip dari lokal directory
    filename         = "${path.module}/lambda/lks_get/lks_get.zip"
    source_code_hash = filebase64sha256("${path.module}/lambda/lks_get/lks_get.zip")

  #Env
  environment {
    variables = {
        DB_HOST = "rds-terra.cwtv1hoknkdd.us-east-1.rds.amazonaws.com"
        DB_PORT = 3306
        DB_USER = "adminterra"
        DB_PASSWORD = "terraP0rt"
        DB_NAME = "terra_db"
    }
  }

  vpc_config {
    subnet_ids = [aws_subnet.subnet-private-1a.id, aws_subnet.subnet-private-2b.id]
    security_group_ids = [ aws_security_group.sg-apps.id, aws_security_group.sg-lb.id ]
  }
}

#Function Get by Id
resource "aws_lambda_function" "lambda-lks-get-id" {
  function_name = "lks-get-id"
  role = "arn:aws:iam::781564733297:role/LabRole"
  handler = "index.handler"
  runtime = "python3.13"

  #Up Zip dari lokal directory
    filename         = "${path.module}/lambda/lks_get_id/lks_get_id.zip"
    source_code_hash = filebase64sha256("${path.module}/lambda/lks_get_id/lks_get_id.zip")

  #Env
  environment {
    variables = {
        DB_HOST = "rds-terra.cwtv1hoknkdd.us-east-1.rds.amazonaws.com"
        DB_PORT = 3306
        DB_USER = "adminterra"
        DB_PASSWORD = "terraP0rt"
        DB_NAME = "terra_db"
    }
  }

  vpc_config {
    subnet_ids = [aws_subnet.subnet-private-1a.id, aws_subnet.subnet-private-2b.id]
    security_group_ids = [ aws_security_group.sg-apps.id, aws_security_group.sg-lb.id ]
  }
}

#Function Post
data "archive_file" "funct-post-arch" {
  type = "zip"
  source_dir = "${path.module}/lambda/lks_post"
  output_path = "${path.module}/lambda/lks_post/lks_post.zip"
}

resource "aws_lambda_function" "lambda-lks-post" {
  function_name = "lks-post"
  role = "arn:aws:iam::781564733297:role/LabRole"
  handler = "index.handler"
  runtime = "python3.13"

  #Up Zip dari lokal directory
    filename         = "${path.module}/lambda/lks_post/lks_post.zip"
    source_code_hash = data.archive_file.funct-post-arch.output_base64sha256

  #Env
  environment {
    variables = {
        DB_HOST = "rds-terra.cwtv1hoknkdd.us-east-1.rds.amazonaws.com"
        DB_PORT = 3306
        DB_USER = "adminterra"
        DB_PASSWORD = "terraP0rt"
        DB_NAME = "terra_db"
    }
  }

  vpc_config {
    subnet_ids = [aws_subnet.subnet-private-1a.id, aws_subnet.subnet-private-2b.id]
    security_group_ids = [ aws_security_group.sg-apps.id, aws_security_group.sg-lb.id ]
  }
}

#Function pUT
data "archive_file" "funct-put-arch" {
  type = "zip"
  source_dir = "${path.module}/lambda/lks_put"
  output_path = "${path.module}/lambda/lks_put/lks_put.zip"
}

resource "aws_lambda_function" "lambda-lks-put" {
  function_name = "lks-put"
  role = "arn:aws:iam::781564733297:role/LabRole"
  handler = "index.handler"
  runtime = "python3.13"

  #Up Zip dari lokal directory
    filename         = "${path.module}/lambda/lks_put/lks_put.zip"
    source_code_hash = data.archive_file.funct-put-arch.output_base64sha256

  #Env
  environment {
    variables = {
        DB_HOST = "rds-terra.cwtv1hoknkdd.us-east-1.rds.amazonaws.com"
        DB_PORT = 3306
        DB_USER = "adminterra"
        DB_PASSWORD = "terraP0rt"
        DB_NAME = "terra_db"
    }
  }

  vpc_config {
    subnet_ids = [aws_subnet.subnet-private-1a.id, aws_subnet.subnet-private-2b.id]
    security_group_ids = [ aws_security_group.sg-apps.id, aws_security_group.sg-lb.id ]
  }
}