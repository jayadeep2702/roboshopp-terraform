data "aws_ami" "frontend" {
  owners      = ["973714476881"]
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
}

output "aws_ami" {
  value = data.aws_ami.frontend.image_id
}



resource "aws_instance" "frontend" {
  ami           = "ami-08ee87f57b38db5af"
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}

output "aws_instance" {
  value = aws_instance.frontend.public_ip
}