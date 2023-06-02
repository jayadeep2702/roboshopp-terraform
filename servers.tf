data "aws_ami" "centos" {
  owners      = ["973714476881"]
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
}

data "aws_security_group" "allow-all" {
  name = "allow-all"
}


variable "instance_type" {
  default = "t3.small"
}

variable "components" {
  default = ["frontend", "mongodb", "catalogue"]
}
resource "aws_instance" "instance" {
  count        =  var.components
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id ]

  tags = {
    Name = var.components[count.index]
  }
}

/*
resource "aws_route53_record" "frontend" {
  zone_id = "Z02359642VV81PVIOF0ZQ"
  name    = "frontend-dev.jdevops72.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.]
}
resource "aws_instance" "instance" {
  count = length(var.components)
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id]

  tags = {
    Name = var.components[count.index]
  }
}


resource "aws_instance" "mongodb" {
  ami           =  data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all]

  tags = {
    Name = "mongodb"
  }
}
resource "aws_route53_record" "mongodb" {
  zone_id = "Z02359642VV81PVIOF0ZQ"
  name    = "mongodb-dev.jdevops72.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.mongodb.private_ip]
}
resource "aws_instance" "catalogue" {
  ami           =  data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all]

  tags = {
    Name = "catalogue"
  }
}
resource "aws_route53_record" "catalogue" {
  zone_id = "Z02359642VV81PVIOF0ZQ"
  name    = "catalogue-dev.jdevops72.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.catalogue.private_ip]
}
resource "aws_instance" "redis" {
  ami           =  data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all]

  tags = {
    Name = "redis"
  }
}
resource "aws_route53_record" "redis" {
  zone_id = "Z02359642VV81PVIOF0ZQ"
  name    = "redis-dev.jdevops72.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.redis.private_ip]
}
resource "aws_instance" "cart" {
  ami           =  data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id]

  tags = {
    Name = "cart"
  }
}
resource "aws_route53_record" "cart" {
  zone_id = "Z02359642VV81PVIOF0ZQ"
  name    = "cart-dev.jdevops72.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.cart.private_ip]
}
resource "aws_instance" "user" {
  ami           =  data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id]

  tags = {
    Name = "user"
  }
}
resource "aws_route53_record" "user" {
  zone_id = "Z02359642VV81PVIOF0ZQ"
  name    = "user-dev.jdevops72.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.user.private_ip]
}
resource "aws_instance" "mysql" {
  ami           =  data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id]

  tags = {
    Name = "mysql"
  }
}
resource "aws_route53_record" "mysql" {
  zone_id = "Z02359642VV81PVIOF0ZQ"
  name    = "mysql-dev.jdevops72.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.mysql.private_ip]
}
resource "aws_instance" "shipping" {
  ami           =  data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id]

  tags = {
    Name = "shipping"
  }
}
resource "aws_route53_record" "shipping" {
  zone_id = "Z02359642VV81PVIOF0ZQ"
  name    = "shipping-dev.jdevops72.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.shipping.private_ip]
}
resource "aws_instance" "rabbitmq" {
  ami           =  data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id]

  tags = {
    Name = "rabbitmq"
  }
}
resource "aws_route53_record" "rabbitmq" {
  zone_id = "Z02359642VV81PVIOF0ZQ"
  name    = "rabbitmq-dev.jdevops72.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.rabbitmq.private_ip]
}
resource "aws_instance" "payment" {
  ami           =  data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ data.aws_security_group.allow-all.id]

  tags = {
    Name = "payment"
  }
}
resource "aws_route53_record" "payment" {
  zone_id = "Z02359642VV81PVIOF0ZQ"
  name    = "payment-dev.jdevops72.online"
  type    = "A"
  ttl     = 300
  records = [aws_instance.payment.private_ip]
*/
