# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"

   config.vm.provider "virtualbox" do |vb|
     vb.memory = "4096"
   end

   config.vm.post_up_message = "Run Postgres with su postgres -c '/usr/local/pgsql/bin/pg_ctl -D $PGDATA -l logfile start'"
  
   config.vm.provision "shell", path: "provisionDB.sh"
end
