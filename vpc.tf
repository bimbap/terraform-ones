#VPC
resource "aws_vpc" "hello-terraform" {
    cidr_block = "10.0.0.0/16"
    assign_generated_ipv6_cidr_block = true
    enable_dns_hostnames = true
    tags = {
        Name = "hello-terraform"
    }
}

# <------[PUBLIC AREA]------>

#subnet 1a public
resource "aws_subnet" "subnet-public-1a" {
    vpc_id = aws_vpc.hello-terraform.id
    cidr_block = "10.0.0.0/24"
    ipv6_cidr_block = cidrsubnet(aws_vpc.hello-terraform.ipv6_cidr_block, 8, 1)  # Blok /64 dari /56 VPC
    assign_ipv6_address_on_creation = true  # Auto-assign IPv6
    availability_zone = "us-east-1a"
    tags = {
        Name = "subnet-public-1a"
    }
}

#subnet 1b public
resource "aws_subnet" "subnet-public-2b" {
    vpc_id = aws_vpc.hello-terraform.id
    cidr_block = "10.0.1.0/24"
    ipv6_cidr_block = cidrsubnet(aws_vpc.hello-terraform.ipv6_cidr_block, 8, 2)  # Blok /64 dari /56 VPC
    assign_ipv6_address_on_creation = true  # Auto-assign IPv6
    availability_zone = "us-east-1b"
    tags = {
        Name = "subnet-public-2b"
    }
}

#igw
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.hello-terraform.id
    tags = {
        Name = "igw-terraform"
    }
}

resource "aws_egress_only_internet_gateway" "igw-egress" {
  vpc_id = aws_vpc.hello-terraform.id

  tags = {
    Name = "igw-egress"
  }
}


#route table public subnet
resource "aws_route_table" "public-rtb-terraform" {
    vpc_id = aws_vpc.hello-terraform.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
  }
  
    tags = {
        Name = "publicRoute"
    }
}

#route table public associate
resource "aws_main_route_table_association" "rtb-associaation-public" {
  vpc_id         = aws_vpc.hello-terraform.id
  route_table_id = aws_route_table.public-rtb-terraform.id
}

resource "aws_route_table_association" "rtb-associaation-public-1a" {
  subnet_id         = aws_subnet.subnet-public-1a.id
  route_table_id = aws_route_table.public-rtb-terraform.id
}

resource "aws_route_table_association" "rtb-associaation-public-2b" {
  subnet_id         = aws_subnet.subnet-public-2b.id
  route_table_id = aws_route_table.public-rtb-terraform.id
}


# <------[PRIVATE AREA]------>

#subnet 1a private
resource "aws_subnet" "subnet-private-1a" {
    vpc_id = aws_vpc.hello-terraform.id
    cidr_block = "10.0.2.0/24"
    ipv6_cidr_block = cidrsubnet(aws_vpc.hello-terraform.ipv6_cidr_block, 8, 3)  # Blok /64 dari /56 VPC
    assign_ipv6_address_on_creation = true  # Auto-assign IPv6
    availability_zone = "us-east-1a"
    tags = {
        Name = "subnet-private-1a"
    }
}

#subnet 1b private
resource "aws_subnet" "subnet-private-2b" {
    vpc_id = aws_vpc.hello-terraform.id
    cidr_block = "10.0.3.0/24"
    ipv6_cidr_block = cidrsubnet(aws_vpc.hello-terraform.ipv6_cidr_block, 8, 4)  # Blok /64 dari /56 VPC
    assign_ipv6_address_on_creation = true  # Auto-assign IPv6
    availability_zone = "us-east-1b"
    tags = {
        Name = "subnet-private-2b"
    }
}

resource "aws_eip" "eip-terraform" {
  domain   = "vpc"
  tags = {
    Name = "nat-eip-terraform"
  }
}

#route table private subnet
resource "aws_route_table" "private-rtb-terraform"  {
  vpc_id = aws_vpc.hello-terraform.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-terraform.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.igw-egress.id
  }

  tags = {
    Name = "privateRoute"
  }
}


#route table public associate
resource "aws_main_route_table_association" "rtb-associaation-private-vpc" {
  vpc_id         = aws_vpc.hello-terraform.id
  route_table_id = aws_route_table.private-rtb-terraform.id
}

resource "aws_route_table_association" "rtb-associaation-private-subnet-1b" {
  subnet_id         = aws_subnet.subnet-private-1a.id
  route_table_id = aws_route_table.private-rtb-terraform.id
}

resource "aws_route_table_association" "rtb-associaation-private-subnet-2b" {
  subnet_id         = aws_subnet.subnet-private-2b.id
  route_table_id = aws_route_table.private-rtb-terraform.id
}

resource "aws_nat_gateway" "nat-terraform" {
  allocation_id = aws_eip.eip-terraform.id
  subnet_id     = aws_subnet.subnet-public-1a.id

  tags = {
    Name = "nat-terraform"
  }
}