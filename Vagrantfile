# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
 config.vm.define "twichblade-vm"
 config.vm.box = "ubuntu/trusty64"
 #config.vm.hostname = "twichblade"
 config.vm.box_check_update = false


 config.vm.network "private_network", ip: "192.168.1.220"

 config.vm.synced_folder "./", "/home/vagrant/app"

 config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
 end

 config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

 config.vm.provision "shell", privileged: false, inline: <<-SHELL


   SHELL
end
