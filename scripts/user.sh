#!/bin/bash

shell_user_name="pia"
shell_user_pwd=""
create_shell_user=false
pwd_salt=""

. ./config.sh

apt update
apt -y install haveged

# Check shell user name
if [ ${#shell_user_name} -eq 0 ]; then
    while true; do
        read -p "Setup the shell user name: " input
        case $input in
            "" ) ;;
            *  ) shell_user_name=$input;
                 # Update config.sh
                 grep -q "^shell_user_name=" ./config.sh && sed -i "s/^shell_user_name.*/shell_user_name=\"$shell_user_name\"/" ./config.sh || echo "shell_user_name=\"$shell_user_name\"" >> ./config.sh;
                 break;;
        esac
    done
fi

# Check if shell user already exists
grep -q "^${shell_user_name}:" /etc/passwd || create_shell_user=true

# Check shell user name
if [ ${#shell_user_pwd} -eq 0 ]; then
    while true; do
        read -p "Setup the shell user password: " input
        case $input in
            "" ) ;;
            *  ) shell_user_pwd=$input;
                 # Update config.sh
                 grep -q "^shell_user_pwd=" ./config.sh && sed -i "s/^shell_user_pwd.*/shell_user_pwd=\"$shell_user_pwd\"/" ./config.sh || echo "shell_user_pwd=\"$shell_user_pwd\"" >> ./config.sh;
                 break;;
        esac
    done
fi

# Create shell user if needed
if $create_shell_user; then
    useradd --password $shell_user_pwd $shell_user_name

    #usermod -G sudo pia
    #sed '/Defaults\tsecure_path/ a Defaults        visiblepw' -i /etc/sudoers

    sed -i '/alias ll=/s/^#//g' /home/${shell_user_name}/.bashrc
    sed -i '/alias l=/s/^#//g' /home/${shell_user_name}/.bashrc
else
    # Generate password salt
    if [ ${#pwd_salt} -eq 0 ]; then
        pwd_salt=$(LC_ALL=C; dd if=/dev/urandom bs=256 count=1 2> /dev/null | tr -dc 'a-zA-Z0-9' | head -c 8; echo)
        grep -q "^pwd_salt=" ./config.sh && sed -i "s/^pwd_salt.*/pwd_salt=\"$pwd_salt\"/" ./config.sh || echo "pwd_salt=\"$pwd_salt\"" >> ./config.sh
    fi

    # Encrypt password
    encrypted_pwd=$(openssl passwd -1 -salt ${pwd_salt} ${shell_user_pwd})

    # Update user password
    usermod --password $encrypted_pwd $shell_user_name
fi