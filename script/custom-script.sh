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

echo "creating local_repo"
yum install createrepo -y
mkdir -p /local_repo/puppet4
createrepo /local_repo

echo "Enabling puppet Repository"
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

echo "Adding puppet4 packages and dependency to local_repo"
yum install --downloadonly --downloaddir=/local_repo/puppet4 ntp puppetserver puppet-agent

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
