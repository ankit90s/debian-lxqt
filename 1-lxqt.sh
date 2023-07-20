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

# Exa Installation
apt install -y exa

# install alacritty
apt install -y alacritty

# PDF reader of choice
apt install -y evince

# network manager
apt install -y network-manager-gnome

# browser of choice
apt install -y firefox-esr

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
cp bashrc /home/$username/.bashrc
cp bash_aliases /home/$username/.bash_aliases

# install wallpapers
./wallpapers.sh

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
