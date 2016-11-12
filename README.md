# jenkins_packer
Packer to build vm.box using Jenkins CI

## How to run
1. Edit **centos72.json** file according to you environment.   

2. Run packer with command    

  ```
  packer build -var-file=centos72.json centos.json
  ```

3. To enable logs and run for a virtual box iso   

  ```
  export PACKER_LOG_PATH=./log &&  export  PACKER_LOG=1 && packer build -var-file=centos72.json -only=virtualbox-iso centos.json
  ```
## Apllication Installed in jenkins host

 	- git
	- hashalot
