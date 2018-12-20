#!/bin/bash

scrdir=/tmp/pia-installer
mkdir -p ${scrdir}/scripts

if ! [ -f ${scrdir}/pia-installer.sh ]; then
	wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/pia-installer.sh -O ${scrdir}/pia-installer.sh
fi
if ! [ -f ${scrdir}/config.sh ]; then
	wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/config.sh -O ${scrdir}/config.sh
fi
if ! [ -f ${scrdir}/scripts/prepare.sh ]; then
	wget wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/prepare.sh -O ${scrdir}/scripts/prepare.sh
fi
if ! [ -f ${scrdir}/scripts/user.sh ]; then
	wget wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/user.sh -O ${scrdir}/scripts/user.sh
fi
if ! [ -f ${scrdir}/scripts/postgres.sh ]; then
	wget wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/postgres.sh -O ${scrdir}/scripts/postgres.sh
fi
if ! [ -f ${scrdir}/scripts/ruby.sh ]; then
	wget wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/ruby.sh -O ${scrdir}/scripts/ruby.sh
fi
if ! [ -f ${scrdir}/scripts/nodejs.sh ]; then
	wget wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/nodejs.sh -O ${scrdir}/scripts/nodejs.sh
fi
if ! [ -f ${scrdir}/scripts/pia-back.sh ]; then
	wget wget https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/pia-back.sh -O ${scrdir}/scripts/pia-back.sh
fi

. ${scrdir}/scripts/prepare.sh
. ${scrdir}/scripts/user.sh
. ${scrdir}/scripts/postgres.sh
. ${scrdir}/scripts/ruby.sh
. ${scrdir}/scripts/nodejs.sh
. ${scrdir}/scripts/pia-back.sh