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

## Xfce4 packages installation
echo -e "\e[1;32m Installing xfce desktop plugins \e[0m"
apt install -y xfce4-panel --no-install-suggests --no-install-recommends
apt install -y clipman xfce4-clipman-plugin
apt install -y xfce4-power-manager
apt install -y xfce4-appmenu-plugin
apt install -y thunar-archive-plugin
apt install -y xfce4-screenshooter
apt install -y xfce4-whiskermenu-plugin
wget https://mxrepo.com/mx/repo/pool/main/x/xfce4-docklike-plugin/xfce4-docklike-plugin_0.4.1-0.1~mx23+1_amd64.deb -O docklike.deb
apt install -y ./docklike.deb
rm docklike.deb

# Exa Installation
apt install -y exa

# install alacritty
apt install -y alacritty

# PDF reader of choice
apt install -y evince

# screenshot
apt install -y screengrab

# network manager
apt install -y nm-tray

# browser of choice
apt install -y chromium

# setup starship
wget https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-musl.tar.gz
tar -xvzf starship-x86_64-unknown-linux-musl.tar.gz
mv starship /usr/local/bin
rm starship-x86_64-unknown-linux-musl.tar.gz

# fast-cli
wget https://github.com/ddo/fast/releases/download/v0.0.4/fast_linux_amd64 -O fast
chmod +x fast
mv fast /usr/local/bin

# pfetch
git clone https://github.com/dylanaraps/pfetch.git
cd pfetch
install pfetch /usr/local/bin
cd ..
rm -rf pfetch

# Copy xresources
# cp Xresources /home/$username/.Xresources
# cp Xresources ~/.Xresources

# copy bashrc and bash_aliases
echo -e "\e[1;32m Installing bashrc and bash aliases \e[0m"
cp bashrc /home/$username/.bashrc
cp bash_aliases /home/$username/.bash_aliases

cp bashrc-root /root/.bashrc
cp bash_aliases /root/.bash_aliases

# Make ISO directory
mkdir /home/$username/ISOs
chown $username:$username /home/$username/*

# install login manager
apt install -y lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings slick-greeter lightdm-settings numlockx
rm -rf /etc/lightdm
cp -r settings/lightdm /etc

# Copy grub file
rm /etc/default/grub
cp settings/grub /etc/default

# own files
chown -R $username:$username /home/$username

# update grub
update-grub

echo 
echo lxqt install complete, Reboot and Enjoy
echo
