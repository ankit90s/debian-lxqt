#!/bin/sh

## check for sudo/root
if ! [ $(id -u) = 0 ]; then
  echo "This script must run with sudo, try again..."
  exit 1
fi

# Copy Source file
mv /etc/apt/sources.list /etc/apt/sources.list.bkp
cp sources.list /etc/apt/sources.list
apt update && apt upgrade -y

# Get username and make builddir
username=$(id -u -n 1000)
builddir=$(pwd)

# install lxqt desktop
apt install -y lxqt-core

# Apps of choice
apt install -y pip ranger cmatrix espeak ncdu translate-shell rsync kdeconnect yt-dlp gpick

# Exa Installation
apt install -y exa

# terminal of choice
apt install -y xterm terminator

# Browser of choice
apt install -y firefox-esr

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
apt install -y neovim geany
git clone https://github.com/VundleVim/Vundle.vim.git /home/$username/.vim/bundle/Vundle.vim

# Papirus icon
apt install -y papirus-icon-theme -t bullseye-backports

# Papirus folder
wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C yaru --theme Papirus-Dark

# WhiteSur Icon Theme
cd /home/$username
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme
mkdir -p /home/$username/.local/share/icons
./install.sh -d /home/$username/.local/share/icons
cd .. && rm -rf WhiteSur-icon-theme
cd builddir

# Restricted extras
apt install -y ttf-mscorefonts-installer rar unrar libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi

# Alacritty Dependencies
apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

# libreoffice install
apt install -y libreoffice-gtk3 libreoffice-impress libreoffice-calc libreoffice-writer

# libreoffice sifr theme
curl -s https://raw.githubusercontent.com/rizmut/libreoffice-style-sifr/master/install-sifr.sh | sh

# install build tools
apt install -y build-essential linux-headers-$(uname -r)

# install nvidia detect
apt install -y nvidia-detect

# setup starship
wget https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-musl.tar.gz
tar -xvzf starship-x86_64-unknown-linux-musl.tar.gz
mv starship /usr/local/bin
rm starship-x86_64-unknown-linux-musl.tar.gz

# Copy xresources
cp Xresources /home/$username/.Xresources
# cp Xresources ~/.Xresources

# copy bashrc and bash_aliases
cp bashrc /home/$username/.bashrc
cp bash_aliases /home/$username/.bash_aliases

# install login manager
apt install -y lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings slick-greeter lightdm-settings numlockx

echo 
echo lxqt install complete, Reboot and Enjoy
echo
