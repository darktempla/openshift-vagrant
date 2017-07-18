# Openshift Vagrant

Project for spinning OpenShift up on a CentOS VM using Vagrant.

# Script Parameters

You can change these parameters as desired

	OC_TOOLS_START = true/false - start the cluster when creating the vagrant VM   	(default: true)
	OC_TOOLS_VERSION = the oc tools versions to download
	OC_TOOLS_VERSION_HASH = the git hash of the oc version to download

# Running

To get it up and running enter the following command:

	vagrant up

# Network Configuration

Private Network only accessible from the host.

# Manually Creating a Cluster

Below is the command to run to create a OpenShift cluster. If OC_START is set to true then this will automatically be run.

	# create and start a new openshift cluster
	oc cluster up --public-hostname='10.0.15.10' --host-data-dir='/home/vagrant/openshift/profiles/default/data' --host-config-dir='/home/vagrant/openshift/profiles/default/config'

# Stopping the cluster 
	oc cluster down

# Access the oc cluster via web inside vagrant machine

Enter the following URL in your browser to access the OpenShift console (UI):

	https://10.0.15.10:8443/console