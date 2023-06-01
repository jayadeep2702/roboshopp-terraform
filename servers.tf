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