#!/bin/bash

# list partitions

lsblk

fdisk /dev    # fill in your disk name and create boot and arch partitions

mkfs.vfat -F32 /dev/    # fill in your boot partition

# To create luks partition:

$bootpartition =    # fill in partition name
$mypartition =    # fill in partition name

cryptsetup luksFormat /dev/$mypartition

cryptsetup open /dev/$mypartition enc
# Create LVM
pvcreate /dev/mapper/enc
vgcreate inc /dev/mapper/enc

# Create logical volumes
lvcreate -L 60G -n arch inc
lvcreate -L 16G -C y -n swap inc

# Format arch LV as Btrfs
mkfs.btrfs /dev/inc/arch

# Mount and create subvolumes
mount /dev/inc/arch /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots

# mount boot partiton and enable swap
mount --mkdir $bootpartition /mnt/boot
swapon /dev/inc/swap

# To backup the current mirror list, run:
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

#Let us retrieve mirrors and sort the mirror list by their download rate, and save them using command:
reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

#You can verify it by:
cat /etc/pacman.d/mirrorlist

# update pacman database
pacman -Syy

# install essentails pkgs

genfstab -U /mnt >> /mnt/etc/fstab
# check
vim /mnt/etc/fstab


# install bootloader after doing extra configs for lvm and encryption
systemd-firstboot --root /mnt --prompt

# post install

arch-chroot /mnt

hwclock --systohc

# uncomment "en_US.UTF-8 UTF-8"
vim /etc/locale.gen

# generate locals
locale-gen

# LANG=en_US.UTF-8
vim /etc/locale.conf

vim /etc/hostname

# install pkgs
bash ./install.sh

mkinitcpio -P

passwd

# unmount all partitions
umount -R /mnt

# deal with "busy" partitions. u can use fuse?
