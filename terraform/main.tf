provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  instance_type = var.instance_type
  ami           = var.ami
  count         = var.count
  key_name      = var.keypair
  security_groups = [var.sec1_id]
  subnet_id     = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name = "web"
  }

connection {
    host = aws_instance.web.0.public_ip
    user = var.username
    private_key   = file(var.private_key)
  }

  provisioner "file" {
    source        = "files/test.sh"
    destination   = "/tmp/test.sh"

  }

 provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/test.sh",
      "sudo bash -c /tmp/test.sh"
    ]
  }
}

