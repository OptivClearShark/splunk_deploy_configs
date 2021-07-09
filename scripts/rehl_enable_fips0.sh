#!/bin/bash
sudo yum install dracut-fips -y
sudo yum install dracut-fips-aesni -y
sudo yum install grubby -y
sudo rpm -q prelink && sed -i '/^PRELINKING/s,yes,no,' /etc/sysconfig/prelink
sudo rpm -q prelink && prelink -uav
sudo mv -v /boot/initramfs-$(uname -r).img{,.bak}
sudo dracut
sudo grubby --update-kernel=$(sudo grubby --default-kernel) --args=fips=1
uuid=$(sudo findmnt -no uuid /boot)
[[ -n $uuid ]] && sudo grubby --update-kernel=$(sudo grubby --default-kernel) --args=boot=UUID=${uuid}
sudo shutdown -r +5
echo "0"
