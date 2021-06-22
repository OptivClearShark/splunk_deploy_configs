#!/bin/bash

cd /tmp
sudo adduser splunk
sudo yum install wget -y
sudo wget -O splunkforwarder-8.1.0-f57c09e87251-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.0&product=universalforwarder&filename=splunkforwarder-8.1.0-f57c09e87251-linux-2.6-x86_64.rpm&wget=true'
sudo rpm -i /tmp/splunkforwarder-8.1.0-f57c09e87251-linux-2.6-x86_64.rpm
sudo chown -R splunk:splunk /opt/splunkforwarder
sudo chmod -R 755 /opt/splunkforwarder
sudo usermod -aG adm splunk
sudo -u splunk bash -c 'cat <<EOF > /opt/splunkforwarder/etc/system/local/user-seed.conf
[user_info]
USERNAME = admin
PASSWORD = clearshark123

EOF'

sudo bash -c 'cat <<EOF > [Unit]
Description=Splunk service
Wants=network.target
After=network.target

[Service]
Restart=always
Type=simple
ExecStart=$SPLUNK_HOME/bin/splunk _internal_launch_under_systemd --accept-license --no-prompt --answer-yes
Delegate=true
#Splunk defines successful exit codes other than 0 to indicate special exit scenarios which are
#used by splunk operations like rolling-restart, offline etc.
SuccessExitStatus=51 52
RestartPreventExitStatus=51
RestartForceExitStatus=52
RemainAfterExit=no
#On some systemd installations, systemd does not create cgroups for memory and cpu controller under system.slice
#rather it runs process under root cgroups, we can force systemd to create cgroups under system.slice by specifying
#MemoryLimit and CPUShares, please look at description below.
MemoryLimit=100G
CPUShares=8192
#If you want to run splunk as root user, comment out the following five lines:
PermissionsStartOnly=true
User=splunk
Group=splunk
ExecStartPost=/bin/bash -c "chown -R splunk:splunk /sys/fs/cgroup/cpu/system.slice/%n"
ExecStartPost=/bin/bash -c "chown -R splunk:splunk /sys/fs/cgroup/memory/system.slice/%n"

[Install]
WantedBy=multi-user.target
EOF'
sudo systemctl daemon-reload
sudo systemctl enable Splunkd.service
sudo -u splunk /opt/splunkforwarder/bin/splunk start  --answer-yes --accept-license
cd $HOME
echo "export PATH=/opt/splunkforwarder/bin:$PATH" >> .bashrc
source .bashrc
