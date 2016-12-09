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
yum -y install wget nano emacs vim

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

echo "Installing python-pip python-wheel"
#Installing python-pip python-wheel
yum -y install python-pip python-wheel

echo "Installing ez_setup"
#Installing ez_setup
wget https://bootstrap.pypa.io/ez_setup.py -O - | python

echo "Upgarding setuptools"
#Upgarding setuptools
pip install --upgrade setuptools

echo "Installing ansible-container"
#Installing ansible-container
pip install ansible-container

echo "Installing pywinrm"
#Installing pywinrm
pip install "pywinrm>=0.1.1"

echo "Installing python-kerberos dependencies"
#Installing python-kerberos dependencies
yum -y install python-devel krb5-devel krb5-libs krb5-workstation

echo "Installing python-kerberos"
#Installing python-kerberos
pip install kerberos requests_kerberos

echo "creating local_repo"
yum install createrepo -y
mkdir -p /local_repo/
createrepo /local_repo

echo "Adding packages and dependency to local_repo"
yum install --downloadonly --downloaddir=/local_repo ntp httpd mariadb-server mariadb php php-mysql php-fpm php-common php-cli php-dba tree screen git bzip2 telnet telnet-server tcptraceroute traceroute bind-utils nmap

echo "Adding Repo Entry"
sudo tee /etc/yum.repos.d/local_repo.repo <<-'EOF'
[local_repo]
name=local Repository
baseurl=file:///local_repo
enabled=1
gpgcheck=0
EOF

echo "Updating local_repo"
createrepo --update /local_repo
