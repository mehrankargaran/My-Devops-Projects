terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.2"
    }
  }
}

provider "null" {}

locals {
  remote_vms = {
    "vm119" = "192.168.2.119"
    "vm120" = "192.168.2.120"
  }
}

# نصب nginx و اجرای اسکریپت روی هر VM ریموت
resource "null_resource" "install_nginx_remote" {
  for_each = local.remote_vms

  connection {
    type     = "ssh"
    host     = each.value
    user     = "mehran"
    password = "amd233"
  }

  # مرحله ۱: نصب nginx
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }

  # مرحله ۲: کپی و اجرای اسکریپت bash
  provisioner "file" {
    source      = "${path.module}/install_nginx.sh"
    destination = "/tmp/install_nginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /tmp/install_nginx.sh"
    ]
  }
}
