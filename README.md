# Openshift Vagrant

Project for spinning OpenShift up on a CentOS VM using Vagrant.

# Network Configuration

Private Network only accessible from the host.

# Creating the Cluster

	# create and start a new openshift cluster
	oc cluster up --public-hostname='10.0.15.10' --host-data-dir='/home/vagrant/openshift/profiles/nonprod/data' --host-config-dir='/home/vagrant/openshift/profiles/nonprod/config'

# Stopping the cluster 
	oc cluster down

# Access the oc cluster via web inside vagrant machine
	https://10.0.15.10:8443/console