#########################################################
##
## Script: Exec_Bonnie
## Author: Steven Poitras
## Description: Run Bonnie++ tests
##
##########################################################
# BEGIN
# Make bonnie++ results folder
mkdir ~/bonnieResults
##################
## 6 disk tests ##
##################
#echo "Running 6 disk 1 thread test..."
#bonnie++ -d /mnt/6vd_lvm/ -x 1 -qfb | bon_csv2html > ~/bonnieResults/6vd_1thread.html &
# Sleep
sleep 10m
# 6 threads
echo "Running 6 disk 6 thread test..."
bonnie++ -p 6
bonnie++ -d /mnt/6vd_lvm/ -x 1 -qfby > /mnt/6vd_lvm/out1 &
bonnie++ -d /mnt/6vd_lvm/ -x 1 -qfby > /mnt/6vd_lvm/out2 &
bonnie++ -d /mnt/6vd_lvm/ -x 1 -qfby > /mnt/6vd_lvm/out3 &
bonnie++ -d /mnt/6vd_lvm/ -x 1 -qfby > /mnt/6vd_lvm/out4 &
bonnie++ -d /mnt/6vd_lvm/ -x 1 -qfby > /mnt/6vd_lvm/out5 &
bonnie++ -d /mnt/6vd_lvm/ -x 1 -qfby > /mnt/6vd_lvm/out6 &
# Sleep
sleep 10m
# Format results
cat /mnt/6vd_lvm/out1 /mnt/6vd_lvm/out2 /mnt/6vd_lvm/out3 /mnt/6vd_lvm/out4
Virtualizing Splunk on Nutanix
/mnt/6vd_lvm/out5 /mnt/6vd_lvm/out6 | bon_csv2html > ~/bonnieResults/6vd_6threads.html
# Compress test results
now=$(date +"%m_%d_%Y")
tar -zcvf $BLOCK_SIZE-K-bonnieResults__$now.tar.gz ~/bonnieResults/
# END
