variable "components" {
  default = {
    frontend = {
      name = "frontend"
      instance_type = "t3.micro"
    }
    user = {
      name = "user"
      instance_type = "t3.micro"
    }
    mongodb = {
      name = "mongodb"
      instance_type = "t3.micro"
    }
    catalogue = {
      name = "catalogue"
      instance_type = "t3.micro"
    }
    redis = {
      name = "redis"
      instance_type = "t3.micro"
    }
    rabbitmq = {
      name = "rabbitmq"
      instance_type = "t3.micro"
    }
    payment = {
      name = "payment"
      instance_type = "t3.micro"
    }
    shipping = {
      name = "shipping"
      instance_type = "t3.micro"
    }
    cart = {
      name = "cart"
      instance_type = "t3.micro"
    }
    mysql = {
      name = "mysql"
      instance_type = "t3.micro"
    }

  }
}

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