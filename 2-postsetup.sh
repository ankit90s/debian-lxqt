#!/bin/sh

## check for sudo/root
if ! [ $(id -u) = 0 ]; then
  echo "This script must run with sudo, try again..."
  exit 1
fi

apt update && apt upgrade -y

# Get username and make builddir
username=$(id -u -n 1000)
builddir=$(pwd)

# Apps of choice
apt install -y pip ranger cmatrix espeak ncdu translate-shell rsync kdeconnect yt-dlp gpick

# image viewer of choice
# apt autoremove lximage-qt -y
# apt install -y gpicview

# clipboard manager
apt autoremove qlipper -y
apt install -y diodon

# Torrent client
apt install -y transmission-qt

# sensors
apt install -y lm-sensors hddtemp

# Archiving tools
apt install -y zip unzip p7zip-full

# search applications
apt install -y rofi dmenu

# System Monitors
apt install -y conky neofetch htop

# Calculator
apt install -y gnome-calculator

# Download Managers
apt install -y curl wget axel aria2

# Network File Tools/System Events
apt install -y dialog mtools dosfstools avahi-daemon acpi acpid gvfs-backends locate mtp-tools
systemctl enable avahi-daemon
systemctl enable acpid

# redshift
apt install -y redshift

# Arc theme
apt install -y arc-theme

# Text editor
apt install -y neovim geany micro
git clone https://github.com/VundleVim/Vundle.vim.git /home/$username/.vim/bundle/Vundle.vim

# Restricted extras
apt install -y ttf-mscorefonts-installer rar unrar libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi

# install nvidia detect
apt install -y nvidia-detect

# install build tools
apt install -y intel-microcode build-essential linux-headers-$(uname -r)

# config files
cd /home/$username
git clone https://github.com/ankit90s/dotconfig && cd dotconfig
cp -r * /home/$username/.config
cp -r /home/$username/settings/autostart /home/$username/.config
chown -R $username:$username /home/$username
cd $builddir

echo 
echo REBOOTING NOW
echo

sleep 3s
reboot
