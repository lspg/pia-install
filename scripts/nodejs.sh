#!/bin/bash

nodejs_version="6"

# NODEJS
curl -sL https://deb.nodesource.com/setup_${nodejs_version}.x | bash -
apt update
apt -y install nodejs
npm install npm@latest -g