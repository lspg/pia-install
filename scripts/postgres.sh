#!/bin/bash

db_user_name=""
db_user_pwd=""
create_db_user=false

. ./config.sh

# Install packages
apt update
apt -y install postgresql postgresql-client procps libpq-dev

# Setup database user name
if [ ${#db_user_name} -eq 0 ]; then
    while true; do
        read -p "Setup the database user name: " input
        case $input in
            "" ) ;;
            *  ) db_user_name=$input; break;;
        esac
    done
fi

# Update config.sh
grep -q "^db_user_name" ./config.sh && sed -i "s/^db_user_name.*/db_user_name=\"$db_user_name\"/" ./config.sh || echo "db_user_name=\"$db_user_name\"" >> ./config.sh

# Setup database user password
if [ ${#db_user_pwd} -eq 0 ]; then
    while true; do
        read -p "Setup a password for the database user account: " input
        case $input in
            "" ) ;;
            *  ) db_user_pwd=$input; break;;
        esac
    done
fi

# Update config.sh
grep -q "^db_user_pwd" ./config.sh && sed -i "s/^db_user_pwd.*/db_user_pwd=\"$db_user_pwd\"/" ./config.sh || echo "db_user_pwd=\"$db_user_pwd\"" >> ./config.sh

# Create database user
sudo -i -u postgres psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='$db_user_name';" | grep -q 1 || create_db_user=true
if $create_db_user; then
    echo -e "Inserting user in database"
    sudo -i -u postgres createuser --no-password --superuser $db_user_name
fi

# Update database user password
sudo -i -u postgres psql postgres -tAc "ALTER USER $db_user_name WITH PASSWORD '$db_user_pwd';"