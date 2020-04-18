#!/bin/sh

git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si

yay -S brave-bin nnn sxiv neovim picom fish cmus mpv ttf-symbola ttf-dejavu openssh sshfs \
  alsa-utils xorg-setxkbmap xcape xwallpaper xorg-xinit xorg-server libxinerama libxft \
  adobe-source-han-sans-cn-fonts adobe-source-han-sans-tw-fonts \
  adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts
