#!/usr/bin/env bash

set -eux

# Sample custom configuration script - add your own commands here
# to add some additional commands for your environment
#
# For example:
# yum install -y curl wget git tmux firefox xvfb
echo "Installing Updates"
#Installing updates
yum -y update

echo "Installing Packages"
#Installing Packages
yum -y install tree screen git wget nano emacs vim

echo "Installing Docker Repo"
#Installing Docker Repo
tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

echo "Installing docker-engine"
#Installing docker-engine
yum -y install docker-engine

echo "Installing docker-compose"
#Installing docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m)" > /usr/bin/docker-compose

echo "Installing docker-machine"
#Installing docker-machine
curl -L https://github.com/docker/machine/releases/download/v0.8.2/docker-machine-`uname -s`-`uname -m` > /usr/bin/docker-machine

echo "Installing Ansible"
#Installing Ansible
yum -y install ansible

echo "Installing gcc"
#Installing gcc
yum -y install gcc

echo "Installing python-2.7.12"
#Installing python-2.7.12
cd /usr/src
wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz
tar xzf Python-2.7.12.tgz
cd Python-2.7.12
./configure
make altinstall

echo "Upgarding Pip"
#Upgarding Pip
pip install --upgrade pip

echo "Installing ez_setup"
#Installing ez_setup
wget https://bootstrap.pypa.io/ez_setup.py -O - | python

echo "Upgarding setuptools"
#Upgarding setuptools
pip install --upgrade setuptools

echo "Installing ansible-container"
#Installing ansible-container
pip install ansible-container
