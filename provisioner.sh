#!/bin/bash
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh
yum install -y mdadm smartmontools hdparm gdisk	      
mdadm --zero-superblock /dev/sd[b,c,d,e]
mdadm --create /dev/md0 -l 10 -n 4 /dev/sd[b,c,d,e]
mdadm --detail --scan > /etc/mdadm.conf
sgdisk /dev/md0 -o
sgdisk /dev/md0 -n 1:0:+100M
sgdisk /dev/md0 -n 2:0:+100M
sgdisk /dev/md0 -n 3:0:+100M
sgdisk /dev/md0 -n 4:0:+100M
sgdisk /dev/md0 -N 5
mkfs.xfs /dev/md0p1
mkfs.xfs /dev/md0p2
mkfs.xfs /dev/md0p3
mkfs.xfs /dev/md0p4
mkfs.xfs /dev/md0p5
mkdir /mnt/storage1
mkdir /mnt/storage2
mkdir /mnt/storage3
mkdir /mnt/storage4
mkdir /mnt/storage5
echo "/dev/md0p1 /mnt/storage1 xfs defaults 0 0" >> /etc/fstab
echo "/dev/md0p2 /mnt/storage2 xfs defaults 0 0" >> /etc/fstab
echo "/dev/md0p3 /mnt/storage3 xfs defaults 0 0" >> /etc/fstab
echo "/dev/md0p4 /mnt/storage4 xfs defaults 0 0" >> /etc/fstab
echo "/dev/md0p5 /mnt/storage5 xfs defaults 0 0" >> /etc/fstab
mount -a

