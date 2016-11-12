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
