resource "aws_instance" "instance" {
  for_each = var.components
  ami      = "ami-0b5a2b5b8f2be4ec2"
  instance_type = each.value["instance_type"]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_route53_record" "records" {
  for_each = var.components
  zone_id = "Z02359642VV81PVIOF0ZQ"
  name    = "${each.value["name"]}-dev.jdevops72.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.instance[each.value["name"]].private_ip]
}