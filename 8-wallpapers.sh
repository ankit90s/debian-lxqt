#! /bin/bash

# check for sudo/root
if ! [ $(id -u) = 0 ]; then
  echo "This script must run with sudo, try again..."
  exit 1
fi

# wallpapers
wget https://gitlab.com/dwt1/wallpapers/-/archive/master/wallpapers-master.zip
unzip wallpapers-master.zip -d /usr/share/images/
rm wallpapers-master.zip
