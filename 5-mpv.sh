#! /bin/sh

sudo apt install -y curl apt-transport-https
curl https://non-gnu.uvt.nl/debian/uvt_key.gpg --output uvt_key.gpg
sudo mv uvt_key.gpg /etc/apt/trusted.gpg.d
sudo sh -c 'echo "deb [arch=amd64] https://non-gnu.uvt.nl/debian $(lsb_release -sc) uvt" >> /etc/apt/sources.list.d/non-gnu-uvt.list'
sudo apt update
sudo apt install -y mpv -t "o=UvT"

