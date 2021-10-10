#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Yangon /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
#echo "KEYMAP=de_CH-latin1" >> /etc/vconsole.conf
echo "Aspire-E5-476G" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 Aspire-E5-476G" >> /etc/hosts
echo root:meliodas | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-lts-headers xdg-user-dirs xdg-utils gvfs gvfs-smb bluez bluez-utils pulseaudio alsa-utils pipewire pipewire-alsa pipewire-jack bash-completion rsync acpi acpi_call iptables-nft ipset firewalld acpid ntfs-3g terminus-font

pacman -S xf86-video-intel
pacman -S nvidia-lts nvidia-utils

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
#systemctl enable bluetooth
#systemctl enable cups.service
#systemctl enable sshd
#systemctl enable avahi-daemon
#systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
#systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

useradd -m niko
echo niko:meliodas | chpasswd
usermod -aG libvirt niko

echo "niko ALL=(ALL) ALL" >> /etc/sudoers.d/niko


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




