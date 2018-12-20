#!/bin/bash

shell_user_name=""
db_user_name=""
db_user_pwd=""

. ./config.sh

if [[ ! ${#shell_user_name} -eq 0 && $(getent passwd $shell_user_name) && ${#db_user_name} -gt 0 && ${#db_user_pwd} -gt 0 ]]; then

    if ! [[ -d /home/${shell_user_name}/pia-back ]]; then
        sudo -i -u ${shell_user_name} git clone https://github.com/LINCnil/pia-back.git /home/${shell_user_name}/pia-back
        cat > /home/${shell_user_name}/pia-back/config/database.yml << EOF
    production:
      adapter:  postgresql
      host:     localhost
      encoding: unicode
      database: pia_production
      pool:     5
      username: ${db_user_name}
      password: ${db_user_pwd}
      template: template0
EOF
    else
        sudo su -c "cd /home/${shell_user_name}/pia-back && git pull origin master" -s /bin/bash pia
    fi

    chown -R ${shell_user_name}: /home/${shell_user_name}
    echo -n "SECRET_KEY_BASE: " > /home/${shell_user_name}/pia-back/config/application.yml
    sudo su -c "export PATH=$PATH:/home/${shell_user_name}/.rvm/rubies/ruby-2.5.3/bin && cd /home/${shell_user_name}/pia-back && RAILS_ENV=production bin/rake secret >> /home/${shell_user_name}/pia-back/config/application.yml" -s /bin/bash pia
    sudo su -c "export PATH=$PATH:/home/${shell_user_name}/.rvm/rubies/ruby-2.5.3/bin && cd /home/${shell_user_name}/pia-back && RAILS_ENV=production bin/rake db:create" -s /bin/bash pia
    sudo su -c "export PATH=$PATH:/home/${shell_user_name}/.rvm/rubies/ruby-2.5.3/bin && cd /home/${shell_user_name}/pia-back && RAILS_ENV=production bin/rake db:migrate" -s /bin/bash pia

    # Test pia-back
    # sudo -i -u ${shell_user_name} RAILS_ENV=production bin/rails s

    # Create systemd service
    cat > /etc/systemd/system/pia.service << EOF
[Unit]
Description=PIA

[Service]
Restart=on-failure
Type=simple
User=pia
WorkingDirectory=/home/${shell_user_name}/pia-back
Environment=RAILS_ENV=production
PIDFile=/home/${shell_user_name}/application.pid
ExecStart=/bin/bash -lc 'rvm default do unicorn -D -c /home/${shell_user_name}/unicorn.rb -E production'

[Install]
WantedBy=multi-user.target
EOF
    systemctl reload-daemon
    systemctl start pia
    systemctl enable pia
fi