#!/bin/bash

cd /packer/centos-7.2/jenkins_packer && packer build -force -var-file=centos72.json centos.json
