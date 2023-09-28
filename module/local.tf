locals {
  name = var.env != "" ? "${var.components_name}-${var.env}" : var.components_name
 db_commands = [
   "rm -rf roboshop-shell",
   "git clone https://github.com/jayadeep2702/roboshop-shell.git",
   "cd roboshop-shell",
   "sudo bash ${var.components_name}.sh  ${var.password}"
 ]

  app_commands = [
    "sudo labauto ansible",
    "ansible-pull -i localhost, -U https://github.com/jayadeep2702/raghu-ansible-roboshop roboshop.yaml -e env=${var.env} -e role_name=${var.components_name}"
  ]
  db_tags ={
    Name = "${var.components_name}-${var.env}"
  }
  app_tags ={
    Name = "${var.components_name}-${var.env}"
    Monitor = "true"
  }

}

