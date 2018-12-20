#!/bin/bash

shell_user_name=""
ruby_version="2.5.3"
rails_version="5.0.6"

. ./config.sh

if [[ ! ${#shell_user_name} -eq 0 && $(getent passwd $shell_user_name) ]]; then
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

    # Single user
    sudo su -c "curl -sSL https://get.rvm.io | bash -s stable" -s /bin/bash pia

    # Multi user install
    #sudo -i -u ${shell_user_name} curl -sSL https://get.rvm.io | sudo bash -s stable

    grep -q "^rvm_autoupdate_flag=" /home/${shell_user_name}/.rvmrc || echo "rvm_autoupdate_flag=2" >> /home/${shell_user_name}/.rvmrc

    sudo -i -u ${shell_user_name} rvm get head

    if ! [ -x "$(sudo -i -u ${shell_user_name} command -v ruby)" ]; then
        sudo -i -u ${shell_user_name} rvm install ${ruby_version}
    else
        while true; do
            read -p "Reinstall ruby ${ruby_version} ? [Y/n] " yn
            case $yn in
                n|N    ) break;;
                y|Y|"" ) sudo -i -u ${shell_user_name} rvm reinstall ${ruby_version}; break;;
            esac
        done
    fi        

    sudo -i -u ${shell_user_name} rvm use ${ruby_version} --default
    sudo -i -u ${shell_user_name} gem install rails --version ${rails_version}
else
    echo -e "Missing user ${shell_user_name}"
fi