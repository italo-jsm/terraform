provider "aws" {
    version = "~> 2.0"
    region  = "us-east-1" 
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_sshs"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_sg" {
  name = "allow_sg"
  description = "allow_sg"
  ingress {
    description = "allow_sg_ingress"
    from_port = 0
    to_port = 0
    protocol = -1
    security_groups = ["${aws_security_group.allow_ssh.id}"]
  }

  tags = {
    Name = "allow_sg"
  }
}


resource "aws_instance" "dev" {
    ami = "ami-07ebfd5b3428b6f4d"
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Name = "dev0"
    }
    vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_sg.id}"]
}

resource "aws_instance" "dev1" {
    ami = "ami-07ebfd5b3428b6f4d"
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    tags = {
        Name = "dev1"
    }
    vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}", "${aws_security_group.allow_sg.id}"]
}


