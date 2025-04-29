
#!/bin/bash

LOGFILE="archinstall.log"

# Function to ask for a variable and confirm it
ask_for_variable() {
    local var_name="$1"
    local var_value="$2"
    
    while true; do
        read -rp "Enter the value for $var_name (current: $var_value): " new_value
        if [[ -z "$new_value" ]]; then
            new_value="$var_value"
        fi
        echo "You entered: $new_value"
        read -rp "Is this correct? (Enter = Yes, n + Enter = No): " choice
        if [[ -z "$choice" ]]; then
            echo "$var_name set to: $new_value"
            eval "$var_name=\"$new_value\""
            break
        elif [[ "$choice" == "n" ]]; then
            echo "Please re-enter the value for $var_name."
        else
            echo "Invalid input. Press Enter to confirm, or type 'n' to re-enter."
        fi
    done
}

# Ask for boot and main partitions
ask_for_variable "bootpartition" "$bootpartition"
ask_for_variable "mypartition" "$mypartition"

# List partitions
run_command "lsblk"

# Disk partitioning (manual step)
run_command "fdisk /dev/your-disk"

# Format boot partition
run_command "mkfs.vfat -F32 $bootpartition"

# Encrypt partition
run_command "cryptsetup luksFormat $mypartition"
run_command "cryptsetup open $mypartition enc"

# LVM setup
run_command "pvcreate /dev/mapper/enc"
run_command "vgcreate inc /dev/mapper/enc"

# Logical volumes
run_command "lvcreate -L 60G -n arch inc"
run_command "lvcreate -L 16G -C y -n swap inc"

# Format arch LV as Btrfs
run_command "mkfs.btrfs /dev/inc/arch"

# Mount and create subvolumes
run_command "mount /dev/inc/arch /mnt"
run_command "btrfs subvolume create /mnt/@"
run_command "btrfs subvolume create /mnt/@home"
run_command "btrfs subvolume create /mnt/@snapshots"

# Mount boot partition and enable swap
run_command "mount --mkdir $bootpartition /mnt/boot"
run_command "swapon /dev/inc/swap"

# Backup and update mirrors
run_command "cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak"
run_command "reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
run_command "cat /etc/pacman.d/mirrorlist"

# Update pacman
run_command "pacman -Syy"

# Install additional packages
run_command "bash ./install.sh"

# Generate fstab
run_command "genfstab -U /mnt >> /mnt/etc/fstab"
run_command "vim /mnt/etc/fstab"

# Bootloader config
run_command "systemd-firstboot --root /mnt --prompt"

# Post-install steps
run_command "arch-chroot /mnt"
run_command "hwclock --systohc"

# Configure locale
run_command "vim /etc/locale.gen"
run_command "locale-gen"
run_command "vim /etc/locale.conf"
run_command "vim /etc/hostname"

# Generate initramfs
run_command "mkinitcpio -P"

# Set root password
run_command "passwd"

# Unmount all partitions
run_command "umount -R /mnt"

# Deal with busy partitions
run_command "fstrim -av"
