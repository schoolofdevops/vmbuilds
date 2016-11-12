#!/bin/bash

cd /packer/centos-7.2/jenkins_packer_ansible_build && packer build -force -var-file=centos72.json centos.json
