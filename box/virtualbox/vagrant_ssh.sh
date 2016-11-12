#!/bin/bash

sudo yum install --downloadonly --downloaddir=/vagrant/local_files/updates tree screen git wget nano emacs vim

sudo yum install wget -y && \
cd /tmp/ && wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm && \
cd /tmp/ && rpm -ivh epel-release-7-8.noarch.rpm

sudo yum install --downloadonly --downloaddir=/vagrant/local_files/updates update

sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

sudo yum install --downloadonly --downloaddir=/vagrant/local_files/docker_dependency docker-engine

sudo curl -L "https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m)" > /vagrant/local_files/bin_files/docker-compose

sudo curl -L https://github.com/docker/machine/releases/download/v0.8.2/docker-machine-`uname -s`-`uname -m` > /vagrant/local_files/bin_files/docker-machine
