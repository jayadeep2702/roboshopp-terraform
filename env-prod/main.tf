env              = "prod"
monitor_cidr     = ["172.31.81.60/32"]
bastion_cidr     = ["172.31.42.224/32"]
default_vpc_id   = "vpc-011ad40842dcb9fc1"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_rtid = "rtb-05515a3e79db5ba59"
kms_arn          = "arn:aws:kms:us-east-1:710990938946:key/b71acc0d-7a78-471a-abb2-6aad1d5d57da"
domain_name      = "sdevops72.online"
domain_id        = "Z07140933N3JDP1H4SFEJ"
vpc              = {
  main = {
    cidr_block = "10.10.0.0/16"
    subnets    = {
      public = {
        name       = "public"
        cidr_block = ["10.10.0.0/24", "10.10.1.0/24"]
        azs        = ["us-east-1a", "us-east-1b"]
      }
      web = {
        name       = "web"
        cidr_block = ["10.10.2.0/24", "10.10.3.0/24"]
        azs        = ["us-east-1a", "us-east-1b"]
      }
      app = {
        name       = "app"
        cidr_block = ["10.10.4.0/24", "10.10.5.0/24"]
        azs        = ["us-east-1a", "us-east-1b"]
      }
      db = {
        name       = "db"
        cidr_block = ["10.10.6.0/24", "10.10.7.0/24"]
        azs        = ["us-east-1a", "us-east-1b"]
      }
    }
  }
}

app = {
  frontend = {
    name              = "frontend"
    instance_type     = "t3.small"
    subnet_name       = "web"
    desired_capacity  = 2
    max_size          = 10
    min_size          = 2
    allow_app_cidr    = "public"
    app_port          = 80
    listener_priority = 1
    lb_type           = "public"
    dns_name          = "www"
    parameters        = []
  }
  catalogue = {
    name              = "catalogue"
    instance_type     = "t3.small"
    subnet_name       = "app"
    desired_capacity  = 2
    max_size          = 10
    min_size          = 2
    allow_app_cidr    = "app"
    app_port          = 8080
    listener_priority = 2
    lb_type           = "private"
    parameters        = ["docdb"]
  }

  cart = {
    name              = "cart"
    instance_type     = "t3.small"
    subnet_name       = "app"
    desired_capacity  = 2
    max_size          = 10
    min_size          = 2
    allow_app_cidr    = "app"
    app_port          = 8080
    listener_priority = 3
    lb_type           = "private"
    parameters        = []
  }

  user = {
    name              = "user"
    instance_type     = "t3.small"
    subnet_name       = "app"
    desired_capacity  = 2
    max_size          = 10
    min_size          = 2
    allow_app_cidr    = "app"
    app_port          = 8080
    listener_priority = 4
    lb_type           = "private"
    parameters        = ["docdb"]
  }

  shipping = {
    name              = "shipping"
    instance_type     = "t3.medium"
    subnet_name       = "app"
    desired_capacity  = 2
    max_size          = 10
    min_size          = 2
    allow_app_cidr    = "app"
    app_port          = 8080
    listener_priority = 5
    lb_type           = "private"
    parameters        = ["rds"]
  }

  payment = {
    name              = "payment"
    instance_type     = "t3.small"
    subnet_name       = "app"
    desired_capacity  = 2
    max_size          = 10
    min_size          = 2
    allow_app_cidr    = "app"
    app_port          = 8080
    listener_priority = 6
    lb_type           = "private"
    parameters        = []
  }

}



docdb = {
  main = {
    subnet_name    = "db"
    allow_db_cidr  = "app"
    engine_version = "4.0.0"
    instance_count = 1
    instance_class = "db.t3.medium"
  }
}

rds = {
  main = {
    subnet_name    = "db"
    allow_db_cidr  = "app"
    engine_version = "5.7.mysql_aurora.2.11.2"
    instance_count = 1
    instance_class = "db.t3.large"
  }
}

elasticache = {
  main = {
    subnet_name             = "db"
    allow_db_cidr           = "app"
    engine_version          = "6.x"
    replicas_per_node_group = 1
    num_node_groups         = 1
    node_type               = "cache.t3.micro"
  }
}

rabbitmq = {
  main = {
    subnet_name   = "db"
    allow_db_cidr = "app"
    instance_type = "t3.small"
  }
}


alb = {
  public = {
    name           = "public"
    subnet_name    = "public"
    allow_alb_cidr = null
    internal       = false
  }
  private = {
    name           = "private"
    subnet_name    = "app"
    allow_alb_cidr = "web"
    internal       = true
  }
}