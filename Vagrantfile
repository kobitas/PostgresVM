# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"

   config.vm.provider "virtualbox" do |vb|
     vb.memory = "4096"
   end

   config.vm.post_up_message = "Connect to DB with 'psql -U postgres'"
  
   config.vm.provision "shell", path: "provisionDB.sh"
end
