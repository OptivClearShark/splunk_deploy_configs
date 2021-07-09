#!/bin/bash
#########################################################
 ##
 ## Script: Prep_disks
 ## Author: Steven Poitras
 ## Description: Prep Splunk disks for testing
 ##
 ##########################################################
 # BEGIN
 # Make sure block size set
 if [ -z "$1" ]
then
           echo "You must specify a block size when running the script, example: './
prep_disks 8' exiting"
exit 0 fi
# Export block size for later use
export BLOCK_SIZE=$1
## Configure storage
# Prep LVM pvols
sudo pvcreate -y /dev/sd[b-g]
# 6 disk LVM
sudo vgcreate splunk_vg6 /dev/sd[b-g]
sudo lvcreate -l 100%FREE -i 6 -I $1 -n splunk_vol6 splunk_vg6
sudo mkfs.ext3 -F -m 1 -v /dev/splunk_vg6/splunk_vol6
sudo tune2fs -o journal_data_writeback /dev/splunk_vg6/splunk_vol6
# Make sure workloads are stopped
sudo kill -9 `pidof bonnie++`
sudo /opt/splunk/bin/splunk stop
# Unmount & cleanup directories
sudo umount /mnt/6vd_lvm && sudo rmdir /mnt/6vd_lvm
# Make directories
sudo mkdir /mnt/6vd_lvm
# Write mounts to fstab
echo "/dev/splunk_vg6/splunk_vol6   /mnt/6vd_lvm ext4
noatime,data=writeback,barrier=0,nobh,errors=remount-ro 0
# Mount
sudo mount -a
# Change permissions
sudo chmod 777 /mnt/*vd*
# END
