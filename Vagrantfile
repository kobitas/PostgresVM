# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"

   config.vm.provider "virtualbox" do |vb|
     vb.memory = "4096"
   end
  
   config.vm.provision "shell", inline: <<-SHELL
	PGSRC=https://ftp.postgresql.org/pub/source/v14.4/postgresql-14.4.tar.gz
	PGDATA=/home/postgres
	
	# Install Requirements
	apt-get update
	apt-get install -y gcc make zlib1g zlib1g-dev readline-common libedit2 libedit-dev
	apt-get upgrade -y

	# Download Source File
	cd /tmp
	wget $PGSRC
	tar xvfz postgresql-14.4.tar.gz

	# Install Postgres Server
	cd postgresql-14.4
	./configure
	make install world
	make clean

	# Create Postgres Data Directory
	mkdir $PGDATA

	# Create Postgres DB User
	useradd postgres --home-dir=$PGDATA --shell=/bin/bash
	chown -R postgres $PGDATA

	# Create Database Cluster
	su postgres -c "/usr/local/pgsql/bin/initdb --pgdata=$PGDATA --user=postgres --encoding=utf8 --no-locale"
	su postgres -c "/usr/local/pgsql/bin/pg_ctl -D $PGDATA -l logfile start"

	# Remove tmp files
	rm -rf /tmp/*.tar.gz

	echo "================================================================================================="
	echo "Run Postgres with su postgres -c '/usr/local/pgsql/bin/pg_ctl -D $PGDATA -l logfile start'"
	echo "================================================================================================="
   SHELL
end
