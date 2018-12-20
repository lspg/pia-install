#!/bin/bash

scrdir=/tmp/pia-installer/scripts
mkdir -p ${scrdir}

wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/get-pia-installer.sh -O /tmp/pia-installer/pia-installer-debian.sh
wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/prepare.sh -O ${scrdir}/prepare.sh
wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/user.sh -O ${scrdir}/user.sh
wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/postgres.sh -O ${scrdir}/postgres.sh
wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/ruby.sh -O ${scrdir}/ruby.sh
wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/nodejs.sh -O ${scrdir}/nodejs.sh
wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/pia-back.sh -O ${scrdir}/pia-back.sh

. /tmp/pia-installer/pia-installer-debian.sh