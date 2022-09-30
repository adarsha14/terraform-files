#!/bin/bash
sudo yum update -y
sudo hostnamectl set-hostname ansible 

wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

sudo yum install epel-release-latest-7.noarch.rpm -y

sudo yum update -y


sudo yum install python python-devel python-pip openssl ansible -y

sudo amazon-linux-extras install ansible2

