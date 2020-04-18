#!/bin/sh

# sudo pacman -S nnn sxiv nvim picom fish alsa-utils cmus mpv

[ ! -e  ~/.xinitrc ] && cp config/.xinitrc ~/

[ -e ~/.config/nnn ] && rm -rf ~/.config/nnn
cp -r config/nnn ~/.config/nnn

[ -e ~/.config/sxiv ] &&  rm -rf ~/.config/sxiv
cp -r config/sxiv ~/.config/sxiv

[ -e ~/.config/nvim ] && rm -rf ~/.config/nvim
cp -r config/nvim ~/.config/nvim

[ -e ~/.config/picom ] && rm -rf ~/.config/picom
cp -r config/picom ~/.config/picom

if [ -e ~/.config/fish ]; then
  rm -rf ~/.config/fish
  cp -r config/fish ~/.config/fish
  chsh -s /usr/bin/fish
fi

