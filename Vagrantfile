# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.define "rundeck" do |rundeck|
    rundeck.vm.box = "bento/centos-6.7"
    rundeck.vm.box_version = "2.2.7"

    rundeck.vm.network :private_network, ip: "192.168.35.46"
    rundeck.vm.network :forwarded_port, guest: 22, host: 4991

    rundeck.vm.provision :shell, path: "provision/rundeck.sh", privileged: true
    rundeck.vm.synced_folder "./", "/vagrant", mount_options: ["dmode=777,fmode=777"]
    rundeck.vm.hostname = "dev.rundeck.loc"

    rundeck.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "90"]
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
  end

  config.vm.define "web" do |web|
    web.vm.box = "server4001/php7-centos"
    web.vm.box_version = "0.2.0"

    web.vm.network :private_network, ip: "192.168.35.47"
    web.vm.network :forwarded_port, guest: 22, host: 4992

    web.vm.provision :shell, path: "provision/web.sh", privileged: true
    web.vm.synced_folder "./", "/vagrant", mount_options: ["dmode=777,fmode=777"]
    web.vm.hostname = "dev.rundeck-web.loc"

    web.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "90"]
      vb.customize ["modifyvm", :id, "--memory", "512"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
  end
end
