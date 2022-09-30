#!/bin/bash
# First check if there are any updates
sudo yum update -y

sudo yum install docker* -y

sudo chmod 666 /var/run/docker.sock

sudo systemctl start docker

sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null

sudo chmod +x /usr/local/bin/docker-compose

ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

