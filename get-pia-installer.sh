#!/bin/bash

scrdir=/tmp/pia-installer/scripts

mkdir -p ${scrdir}
curl curl -sSL -o /tmp/pia-installer-debian.sh https://raw.githubusercontent.com/lspg/pia-installer-debian/master/pia-installer-debian.sh
curl curl -sSL -o ${scrdir}/prepare.sh https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/prepare.sh
curl curl -sSL -o ${scrdir}/user.sh https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/user.sh
curl curl -sSL -o ${scrdir}/postgres.sh https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/postgres.sh
curl curl -sSL -o ${scrdir}/ruby.sh https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/ruby.sh
curl curl -sSL -o ${scrdir}/nodejs.sh https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/nodejs.sh
curl curl -sSL -o ${scrdir}/pia-back.sh https://raw.githubusercontent.com/lspg/pia-installer-debian/master/scripts/pia-back.sh