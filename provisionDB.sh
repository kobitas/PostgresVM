#!/bin/bash

PGVERSION=14.4
PGSRC=https://ftp.postgresql.org/pub/source/v$PGVERSION/postgresql-$PGVERSION.tar.gz
PGDATA=/usr/local/pgsql/data
PGBINARIES=/usr/local/pgsql
ERROR_LOG=/tmp/pg_install_error_log.txt
USER=vagrant
INSTALLDIR=/tmp/postgresql-$PGVERSION 

echo "Install Requirements"
apt-get update  &> $ERROR_LOG
apt-get install -y gcc make zlib1g zlib1g-dev readline-common libedit2 libedit-dev &> $ERROR_LOG
apt-get upgrade -y &> $ERROR_LOG

echo "Download Source Files from $PGSRC"
cd /tmp
test -d $INSTALLDIR || wget $PGSRC --output-document=/tmp/postgres-$PGVERSION.tar.gz &>> $ERROR_LOG
tar xvfz /tmp/postgres-$PGVERSION.tar.gz &>> ERROR_LOG

echo "Install Postgres Server version $PGVERSION"
cd $INSTALLDIR
test -f $INSTALLDIR/config.log || ./configure &>> ERROR_LOG && \
make install world &>> ERROR_LOG && \
make clean &>> ERROR_LOG

echo "Create Postgres Data Directory"
mkdir $PGDATA &>> ERROR_LOG

echo "Create Postgres DB User"
useradd postgres --shell=/bin/bash &> $ERROR_LOG
chown -R postgres $PGDATA &>> $ERROR_LOG

echo "Add binaries to user path"
grep "^PATH=$PGBINARIES:$PATH" /home/$USER/.bashrc || echo "PATH=/usr/local/pgsql/bin/:$PATH" >> /home/$USER/.bashrc

echo "Create Database Cluster"
su postgres -c "/usr/local/pgsql/bin/initdb --pgdata=$PGDATA --user=postgres --encoding=utf8 --no-locale" &>> $ERROR_LOG
su postgres -c "/usr/local/pgsql/bin/pg_ctl -D $PGDATA -l logfile start" &>> $ERROR_LOG

echo "Remove tmp files"
rm -rf /tmp/*.tar.gz &> $ERROR_LOG

