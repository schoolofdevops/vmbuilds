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

echo  "Install update & other packages"
# Install update & other packages
cd /opt/local_files/updates
rpm -Uvh *.rpm


echo "Copying 'docker-compose' 'docker-machine' & 'kubectl' and adding to PATH"
#Copying 'docker-compose' 'docker-machine' & 'kubectl'
cp /opt/local_files/bin_files/* /usr/bin/.

echo "Installing Ansible & Ansible Container"
#Installing Ansible & Ansible Container
sudo yum install ansible
sudo yum install gcc
cd /usr/src
wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz
tar xzf Python-2.7.12.tgz
cd Python-2.7.12
./configure
make altinstall
sudo python get-pip.py
wget https://bootstrap.pypa.io/ez_setup.py -O - | python
sudo pip install ansible-container
