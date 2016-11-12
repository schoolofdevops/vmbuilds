#!/usr/bin/env bash

set -eux

# Sample custom configuration script - add your own commands here
# to add some additional commands for your environment
#
# For example:
# yum install -y curl wget git tmux firefox xvfb
echo  "Copying local files"

cd /opt
tar -xzf /tmp/local_files.tar.gz

echo  "Install update packages"
# Install update packages
cd /opt/local_files/updates
rpm -Uvh *.rpm

echo  "Install Docker_dependency packages"
# Install Docker_dependency packages
mkdir -p /var/lib/docker
cd /opt/local_files/docker_dependency
rm -rf libtool-ltdl-2.4.2-21.el7_2.x86_64.rpm
rpm -Uvh *.rpm

echo  "Install Docker package"
# Install Docker package
cd /opt/local_files/docker
rpm -Uvh *.rpm

echo "Copying 'docker-compose' 'docker-machine' & 'kubectl' and adding to PATH"
#Copying 'docker-compose' 'docker-machine' & 'kubectl'
cp /opt/local_files/bin_files/* /usr/bin/.

echo "Installing Ansible"
#Installing Ansible
sudo yum install ansible

echo "Installing gcc"
#Installing gcc
sudo yum install gcc

echo "Installing python-2.7.12"
#Installing python-2.7.12
cd /usr/src
wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz
tar xzf Python-2.7.12.tgz
cd Python-2.7.12
./configure
make altinstall

echo "Installing pip"
#Installing pip
sudo python get-pip.py

echo "Installing ez_setup"
#Installing ez_setup
wget https://bootstrap.pypa.io/ez_setup.py -O - | python

echo "Installing ansible-container"
#Installing ansible-container
sudo pip install ansible-container
