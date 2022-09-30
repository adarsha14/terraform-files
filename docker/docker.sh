#!/bin/bash
# First check if there are any updates
sudo apt-get update -y
# allow apt to use repositories over the HTTPS protocol
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

# Add docker's official GPG key by executing following command
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add docker's repositories
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# update and install docker
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo chmod 666 /var/run/docker.sock

sudo systemctl start docker
#creating docker container
docker run -d -it --name docker-container -p 8080:80 httpd

