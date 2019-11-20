#!/bin/bash

sudo yum install -y httpd
sudo systemctl start httpd
sudo echo "WELCOME TO BITS PILANI" > /var/www/html/index.html
