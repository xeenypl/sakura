#!/bin/bash

export NNN_PLUG='i:imgview'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export EDITOR="nvim"
export BROWSER="qutebrowser"
export SHELL="fish"

export LESSHISTFILE=-

xset dpms 0 0 600
setxkbmap pl -option caps:super
xcape -e 'Shift_L=Escape;Super_L=BackSpace'

picom &
transmission-daemon &
~/.config/wallpaper
slstatus &

while true
do
  dwm
done
