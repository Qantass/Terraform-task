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
    ami = "ami-00399ec92321828f5"      # Linux Ubuntu Server 20.04 LTS
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
