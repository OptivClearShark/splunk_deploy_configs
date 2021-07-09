#!/bin/bash

cd /tmp
sudo adduser splunk
sudo yum install wget -y

sudo wget -O splunk-8.2.1-ddff1c41e5cf-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.2.1&product=splunk&filename=splunk-8.2.1-ddff1c41e5cf-linux-2.6-x86_64.rpm&wget=true'
sudo rpm -i /tmp/splunk-8.2.1-ddff1c41e5cf-linux-2.6-x86_64.rpm
sudo chown -R splunk:splunk /opt/splunk
sudo chmod -R 755 /opt/splunk
sudo usermod -aG adm splunk
sudo -u splunk bash -c 'cat <<EOF > /opt/splunk/etc/system/local/user-seed.conf
[user_info]
USERNAME = admin
PASSWORD = clearshark123!

EOF'

sudo chmod 400 /opt/splunk/var/lib/splunk/kvstore/mongo/splunk.key
sudo /opt/splunk/bin/splunk enable boot-start -systemd-managed 1  -create-polkit-rules 1 -user splunk -group splunk --accept-license --no-prompt --answer-yes
sudo systemctl daemon-reload
sudo systemctl enable Splunkd.service
