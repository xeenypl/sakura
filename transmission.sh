#!/bin/sh

yay -S transmission-cli transmission-remote-cli-git
if [ ! -e /usr/share/applications/transmission.desktop ]; then
  echo [Desktop Entry]                 | sudo tee -a /usr/share/applications/transmission.desktop
  echo Name=Transmission               | sudo tee -a /usr/share/applications/transmission.desktop
  echo Type=Application                | sudo tee -a /usr/share/applications/transmission.desktop
  echo Exec=transmission-remote -a %U  | sudo tee -a /usr/share/applications/transmission.desktop
fi

xdg-mime default transmission.desktop  application/x-bittorrent
xdg-mime default transmission.desktop  x-scheme-handler/magnet
