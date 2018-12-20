#!/bin/bash

scrdir=/tmp/pia-installer
mkdir -p ${scrdir}

wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/prepare.sh -O ${scrdir}/scripts/prepare.sh
wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/user.sh -O ${scrdir}/scripts/user.sh
wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/postgres.sh -O ${scrdir}/scripts/postgres.sh
wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/ruby.sh -O ${scrdir}/scripts/ruby.sh
wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/nodejs.sh -O ${scrdir}/scripts/nodejs.sh
wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/pia-back.sh -O ${scrdir}/scripts/pia-back.sh

. ${scrdir}/scripts/prepare.sh
. ${scrdir}/scripts/user.sh
. ${scrdir}/scripts/postgres.sh
. ${scrdir}/scripts/ruby.sh
. ${scrdir}/scripts/nodejs.sh
. ${scrdir}/scripts/pia-back.sh