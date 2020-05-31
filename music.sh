#!/bin/sh

echo "@audio - rtprio 90"      >> /etc/security/limits.conf
echo "@audio - nice -5"        >> /etc/security/limits.conf
echo "@audio - memlock 750000" >> /etc/security/limits.conf

sudo groupadd audio
sudo usermod -a -G audio $USER

yay -S jack2 ardour 
yay -S x42-plugins lsp-plugins calf eq10q
yay -S samplv1 synthv1
