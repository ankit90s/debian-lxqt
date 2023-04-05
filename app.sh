#!/bin/sh

## check for sudo/root
if ! [ $(id -u) = 0 ]; then
  echo "This script must run with sudo, try again..."
  exit 1
fi

# Get username and make builddir
username=$(id -u -n 1000)
builddir=$(pwd)

# Apps of choice
apt install -y pip ranger cmatrix espeak ncdu translate-shell rsync kdeconnect yt-dlp gpick

# Browser of choice
apt install -y firefox-esr

# image viewer of choice
apt autoremove lximage-qt
apt install -y gpicview

# clipboard manager
apt autoremove qlipper
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
apt install -y neovim geany
git clone https://github.com/VundleVim/Vundle.vim.git /home/$username/.vim/bundle/Vundle.vim

# Papirus icon
apt install -y papirus-icon-theme -t bullseye-backports

# Papirus folder
wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C yaru --theme Papirus-Dark

# Kvantum
apt install -y qt5-style-kvantum

# WhiteSur Icon Theme
cd /home/$username
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme
mkdir -p /home/$username/.local/share/icons
./install.sh -d /home/$username/.local/share/icons
cd .. && rm -rf WhiteSur-icon-theme
cd builddir

# Mc Mojave-kde Theme
git clone https://github.com/vinceliuice/McMojave-kde.git
cd McMojave-kde
./install.sh -d /usr/share/themes
cd .. && rm -rf McMojave-kde

# Mojave gtk theme
apt install -y gtk2-engines-murrine gtk2-engines-pixbuf sassc optipng inkscape libglib2.0-dev-bin libglib2.0-dev libxml2-utils
git clone https://github.com/vinceliuice/Mojave-gtk-theme.git
cd Mojave-gtk-theme
./install.sh -d /usr/share/themes
cd .. && rm -rf Mojave-gtk-theme

# White sur gtk theme
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git && cd WhiteSur-gtk-theme
./install -d /usr/share/themes
cd .. && rm -rf WhiteSur-gtk-theme

# White sur qt theme
git clone https://github.com/vinceliuice/WhiteSur-kde.git && cd WhiteSur-kde
./install -f /usr/share/themes
cd .. && rm -rf WhiteSur-kde

# Restricted extras
apt install -y ttf-mscorefonts-installer rar unrar libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi

# Alacritty Dependencies
apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

# libreoffice install
apt install -y libreoffice-gtk3 libreoffice-impress libreoffice-calc libreoffice-writer

# libreoffice sifr theme
curl -s https://raw.githubusercontent.com/rizmut/libreoffice-style-sifr/master/install-sifr.sh | sh

# install nvidia detect
apt install -y nvidia-detect

# install build tools
apt install -y build-essential linux-headers-$(uname -r)

# config files
cd /home/$username
git clone https://github.com/ankit90s/dotconfig && cd dotconfig
cp -r * /home/$username/.config
chown -R $username:$username /home/$username
cd $builddir

echo 
echo Reboot and Enjoy
echo
