#!/usr/bin/env bash

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
wget https://github.com/openshift/origin/releases/download/v1.5.1/openshift-origin-client-tools-v1.5.1-7b451fc-linux-64bit.tar.gz --quiet
tar -xzf openshift-origin-client-tools-v1.5.1-7b451fc-linux-64bit.tar.gz
echo 'export PATH=$PATH:~/oc-tools/openshift-origin-client-tools-v1.5.1-7b451fc-linux-64bit/' >> /home/vagrant/.bashrc

echo '### Install Docker...'
curl -fsSL https://get.docker.com/ | sh 		# download and install docker
usermod -aG docker vagrant						# add vagrant to docker group to prevent sudoing
docker run hello-world							# verify the installation is successful
systemctl enable docker 						# ensure docker daemon starts on server restart
service docker start

echo '{ "insecure-registries" : ["172.30.0.0/16"] }' > /etc/docker/daemon.json

service docker stop
service docker start

echo '### Setup OpenShift'
mkdir /home/vagrant/openshift

echo '### END: Bootstrapping OpenShift environment...'

#
# After install
#

# create and start a new openshift cluster
# oc cluster up --public-hostname='10.0.15.10' --host-data-dir='/home/vagrant/openshift/profiles/nonprod/data' --host-config-dir='/home/vagrant/openshift/profiles/nonprod/config'

# stop the cluster 
# oc cluster down

# access the oc cluster via web inside vagrant machine
# https://10.0.15.10:8443/console
