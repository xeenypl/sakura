#!/bin/sh


# sudo pacman -S nnn sxiv nvim picom fish alsa-utils cmus mpv

if [ ! -L ~/.config/nnn ]; then
  rm -rf ~/.config/nnn
  ln -s config/nnn ~/.config/nnn
fi

if [ ! -L ~/.config/sxiv ]; then
  rm -rf ~/.config/sxiv
  ln config/sxiv ~/.config/sxiv
fi

if [ ! -L ~/.config/nvim ]; then
  rm -rf ~/.config/nvim
  ln config/nvim ~/.config/nvim
fi

if [ ! -L ~/.config/picom ]; then
  rm -rf ~/.config/picom
  ln config/picom ~/.config/picom
fi

if [ ! -L ~/.config/fish ]; then
  rm -rf ~/.config/fish
  ln config/fish ~/.config/fish
  chsh -s/usr/bin/fish
fi


