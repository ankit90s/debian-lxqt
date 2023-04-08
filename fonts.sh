#!/bin/bash

# This script can be used to install user specific fonts and nerdfonts of one's choice.

## check for sudo/root
if ! [ $(id -u) = 0 ]; then
  echo "This script must run with sudo, try again..."
  exit 1
fi

# fonts
apt install -y fonts-indic fonts-noto-color-emoji fonts-roboto fonts-ubuntu fonts-ubuntu-title fonts-ubuntu-console unifont fonts-cantarell

# Material Design Icon Fonts
mkdir -p /usr/share/fonts/Material-fonts
wget https://github.com/zavoloklom/material-design-iconic-font/releases/download/2.2.0/material-design-iconic-font.zip
unzip material-design-iconic-font.zip -d /usr/share/fonts/Material-fonts/
rm -f material-design-iconic-font.zip
fc-cache -fv

# Microsoft fonts
apt install -y fonts-crosextra-carlito fonts-crosextra-caladea

cd /tmp
fonts=( 
"FiraCode" 
"JetBrainsMono" 
"RobotoMono" 
"UbuntuMono"
)

for font in ${fonts[@]}
do
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$font.zip
    unzip $font.zip -d /usr/share/fonts/$font/
    rm $font.zip
done
fc-cache -fv
