#!/bin/bash

cd /tmp
sudo wget -O splunk-8.1.0-f57c09e87251-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.0&product=splunk&filename=splunk-8.1.0-f57c09e87251-linux-2.6-x86_64.rpm&wget=true'
sudo -u splunk /opt/splunk/bin/splunk stop
sudo rpm -Uhv /tmp/splunk-8.1.0-f57c09e87251-linux-2.6-x86_64.rpm 
sudo chown -R splunk:splunk /opt/splunk
sudo chmod -R 755 /opt/splunk
sudo /opt/splunk/bin/splunk enable boot-start -systemd-managed 1 -user splunk --accept-license --no-prompt --answer-yes
sudo systemctl daemon-reload
sudo systemctl enable Splunkd.service
sudo  /opt/splunk/bin/splunk start  --answer-yes --accept-license
cd $HOME
echo "export PATH=/opt/splunk/bin:$PATH" >> .bashrc
source .bashrc
