resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "TF-VPC"
    }
}

resource "aws_subnet" "public-1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "TF-Subnet-1"
    }
}

resource "aws_instance" "name" {
    ami = ""
    instance_type = "t2.micro"
    tags = {
      Name = "TF-EC2"
    }
}