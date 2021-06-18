#----------------------- A  W  S ---------------------------
provider "aws" {
    profile = "terraform"
    region = "us-east-2"
}

resource "aws_instance" "mysql" {
    ami = "ami-00399ec92321828f5"  # Linux Ubuntu Server 20.04 LTS 
    instance_type = "t2.micro"
}

resource "aws_instance" "tomcat" {
    ami "ami-00399ec92321828f5"  # Linux Ubuntu Server 20.04 LTS
    instance_type = "t2.micro"
}

#---------------------- V  P  C -------------------------------
resource "aws_vpc" "db_vpc" {
  cidr_block       = "10.0.0.0/16"    # VPC 
  instance_tenancy = "default"

  tags = {
    Name = "db_vps"
  }
}

#---------------------- S  U  B ----------------------------------------
resource "aws_subnet" "db1" {
  vpc_id     = aws_vpc.db_vpc.id    # Subnet for mysql
  cidr_block = "10.0.1.0/24"
  
    tags = {
    Name = "MySQL_Sub"
  }
}

resource "aws_subnet" "db2" {
  vpc_id     = aws_vpc.db_vpc.id   # Subnet for tomcat
    cidr_block = "10.0.2.0/24"
  
  tags = {
    Name = "Tomcat_Sub"
  }
}

#------------------ SECURITY GROUP ----------------------------------------
resource "aws_security_group" "DB_Security_group" {
  name = "DB_Security_group"
  description = "My DB_Security_group"
  
  ingress {
    from_port = 3306    # Ports for MySQL
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080    # Port for TomCAT (HTTP)
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8443    # Port for TomCAT (HTTPS)
    to_port = 8443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DB_Security_group"
    Owner = "Qantas"
}