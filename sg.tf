# <-----------------[SG RDS]----------------->
resource "aws_security_group" "sg-db" {
  name        = "db-sg"
  description = "Allow MySQL and all traffic"
  vpc_id      = aws_vpc.hello-terraform.id

  ingress {
    description = "MySQL IPv4"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.hello-terraform.cidr_block]
  }

  ingress {
    description = "MySQL IPv6"
    from_port         = 3306
    to_port           = 3306
    protocol          = "tcp"
    ipv6_cidr_blocks  = [aws_vpc.hello-terraform.ipv6_cidr_block]
  }

  ingress {
    description = "All traffic IPv4"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.hello-terraform.cidr_block]
  }

  ingress {
    description       = "All traffic IPv6"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    ipv6_cidr_blocks  = [aws_vpc.hello-terraform.ipv6_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    ipv6_cidr_blocks  = ["::/0"]
  }

  tags = {
    Name = "SG-RDS"
  }
}



# <-----------------[SG LB]----------------->

resource "aws_security_group" "sg-lb" {
  name        = "lb-sg"
  description = "Allow port http & https"
  vpc_id      = aws_vpc.hello-terraform.id

  ingress {
    description = "HTTP IPv4"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS IPv4"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description       = "HTTP IPv6"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    ipv6_cidr_blocks  = ["::/0"]
  }

  ingress {
    description       = "HTTPS IPv6"
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    ipv6_cidr_blocks  = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    ipv6_cidr_blocks  = ["::/0"]
  }

  tags = {
    Name = "SG-LB"
  }
}


# <-----------------[SG APPS]----------------->

resource "aws_security_group" "sg-apps" {
  name        = "apps-sg"
  description = "Allow SSH, Python App, MySQL"
  vpc_id      = aws_vpc.hello-terraform.id

  ingress {
    description = "SSH IPv4"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Python App IPv4"
    from_port   = 2000
    to_port     = 2000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "MySQL IPv4"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Port 10000 IPv4"
    from_port   = 10000
    to_port     = 10000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH IPv6"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Python App IPv6"
    from_port        = 2000
    to_port          = 2000
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "MySQL IPv6"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "App Port 10000 IPv6"
    from_port        = 10000
    to_port          = 10000
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    ipv6_cidr_blocks  = ["::/0"]
  }

  tags = {
    Name = "SG-Apps"
  }
}