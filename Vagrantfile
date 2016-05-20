# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "server4001/centos65-basic"
  config.vm.box_version = "0.1.0"
  config.vm.network :private_network, ip: "192.168.35.46"
  config.vm.network :forwarded_port, guest: 22, host: 4991
  config.vm.provision :shell, path: "provision.sh", privileged: false
  config.vm.synced_folder "./", "/vagrant", mount_options: ["dmode=775,fmode=664"]
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "90"]
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
end
