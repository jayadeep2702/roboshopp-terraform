resource "aws_instance" "instance" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

  tags = {
    Name = local.name
  }
}

resource "null_resource" "provisioner" {
  depends_on = [aws_instance.instance,aws_route53_record.records]
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }

    inline = var.app_type == "db" ? local.db_commands : local.app_commands
  }
}


resource "aws_route53_record" "records" {

  zone_id = "Z05101383TRG2EDZQVJHC"
  name    = "${var.components_name}-dev.jdevops72.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.instance.private_ip]
}

resource "aws_iam_role" "role" {
  name = "${var.components_name}-${var.env}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.components_name}-${var.env}-role"
  }
}
Example of Using