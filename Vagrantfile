# Defines our Vagrant environment
#
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :openshift do |oc_config|
      oc_config.vm.box = "centos/7"
      oc_config.vm.hostname = "openshift"
      oc_config.vm.network :private_network, ip: "10.0.15.10"
      oc_config.vm.provider "virtualbox" do |vb|
        vb.memory = "4096"
      end
      oc_config.vm.provision :shell, path: "bootstrap.sh"
  end
end
