provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami           = "ami-0520e698dd500b1d1"
  count         = 1
  key_name      = "devops"
  security_groups = ["sg-8bd369e5"]
  subnet_id     = "subnet-21a8df5b"
  associate_public_ip_address = "true"

  tags = {
    Name = "web"
  }

connection {
    #host = "aws_instance.web.*.public_ip"
    host = aws_instance.web.0.public_ip
    user = "ec2-user"
    #private_key   = file("/tmp/devops.pem")
    private_key   = file(var.private_key_path)
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
