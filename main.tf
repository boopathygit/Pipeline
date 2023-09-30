provider "aws" {
  region     = "ap-southeast-2"
}
resource "aws_instance" "web1" {
ami           = "ami-06e2b86bab2edf4ee"
instance_type = "t2.micro"
key_name   = "maternew"
tags = {
    Name = "Test-server-git"
}
}
