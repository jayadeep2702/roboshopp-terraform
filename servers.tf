resource "aws_instance" "instance" {
  for_each      = var.components
  ami           = data.aws_ami.centos.image_id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

  tags = {
    Name = each.value["name"]
  }
}

resource "null_resource" "provisioner" {
  depends_on = [aws_instance.instance,aws_route53_record.records]
  for_each = var.components
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance[each.value["name"]].private_ip
    }

    inline = [
    "rm -rf roboshop-shell",
    "git clone https://github.com/jayadeep2702/roboshopp-shell.git",
    "cd roboshop-shell",
    "sudo bash ${each.value["name"]}.sh  ${lookup(each.value,"password","null")}"
    ]
  }
}


resource "aws_route53_record" "records" {
  for_each = var.components
  zone_id = "Z05101383TRG2EDZQVJHC"
  name    = "${each.value["name"]}-dev.jdevops72.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.instance[each.value["name"]].private_ip]
}
