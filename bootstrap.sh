#!/usr/bin/env bash

#
# Variables
#

OC_START=true

# v3.6.0-rc.0
OC_TOOLS_VERSION="v3.6.0-rc.0"
OC_TOOLS_VERSION_HASH="98b3d56"

#
# Clean Up - handy when running the following command to speed up testing of changes
# > vagrant reload --provision
#

OC_TOOLS_TAR=openshift-origin-client-tools-$OC_TOOLS_VERSION-$OC_TOOLS_VERSION_HASH-linux-64bit.tar.gz
OC_TOOLS_DIR=/home/vagrant/oc-tools
OPENSHIFT_WORKING_DIR=/home/vagrant/openshift

rm -dfr $OC_TOOLS_DIR
rm -dfr $OPENSHIFT_WORKING_DIR

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

mkdir $OC_TOOLS_DIR
cd $OC_TOOLS_DIR

wget https://github.com/openshift/origin/releases/download/$OC_TOOLS_VERSION/$OC_TOOLS_TAR --quiet
tar -xzf $OC_TOOLS_TAR --strip 1
rm 

echo "export PATH=$PATH:$OC_TOOLS_DIR/" >> /home/vagrant/.bashrc

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
mkdir $OPENSHIFT_WORKING_DIR

if [ "$OC_START" = true ] ; then

	echo "### Creating Default OpenShift Cluster"
	$OC_TOOLS_DIR/oc cluster up --public-hostname='10.0.15.10' --host-data-dir='/home/vagrant/openshift/profiles/default/data' --host-config-dir='/home/vagrant/openshift/profiles/default/config'

fi	

echo '### END: Bootstrapping OpenShift environment...'