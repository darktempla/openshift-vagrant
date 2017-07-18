#!/usr/bin/env bash

#
# Variables
#

# v3.6.0-rc.0
OC_VERSION="v3.6.0-rc.0"
OC_VERSION_HASH="98b3d56"

#
# Script
#

echo '### BEGIN: Bootstrapping OpenShift environment...'

echo '### Install Dependencies...'

yum update -y
yum install gcc-c++ patch readline readline-devel zlib zlib-devel gcc ruby-devel libyaml-devel libffi-devel openssl-devel make -y
yum install bzip2 autoconf automake libtool bison iconv-devel zlib-devel -y
yum install ruby nslookup wget -y

gem install json
gem install parseconfig

echo '### Install OpenShift CLI...'

mkdir /home/vagrant/oc-tools
cd /home/vagrant/oc-tools
wget https://github.com/openshift/origin/releases/download/$OC_VERSION/openshift-origin-client-tools-$OC_VERSION-$OC_VERSION_HASH-linux-64bit.tar.gz --quiet
tar -xzf openshift-origin-client-tools-$OC_VERSION-$OC_VERSION_HASH-linux-64bit.tar.gz

echo "export PATH=$PATH:~/oc-tools/openshift-origin-client-tools-$OC_VERSION-$OC_VERSION_HASH-linux-64bit/" >> /home/vagrant/.bashrc

echo '### Install Docker...'
curl -fsSL https://get.docker.com/ | sh 		# download and install docker
usermod -aG docker vagrant						# add vagrant to docker group to prevent sudoing

systemctl enable docker 						# ensure docker daemon starts on server restart
service docker start							# required to create docker directories
service docker stop

echo '{ "insecure-registries" : ["172.30.0.0/16"] }' > /etc/docker/daemon.json

service docker start 							# pick up configuration changes
docker run hello-world							# verify the installation is successful

echo '### Setup OpenShift'
mkdir /home/vagrant/openshift

echo '### END: Bootstrapping OpenShift environment...'
