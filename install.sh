#!/bin/sh

git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si

yay -S qutebrowser brave-bin transmission-cli
yay -S nnn sxiv neovim picom fish cmus mpv man man-pages unxip unrar zip
yay -S ttf-symbola ttf-dejavu adobe-source-han-sans-cn-fonts adobe-source-han-sans-kr-fonts 
yay -S adobe-source-han-sans-tw-fonts adobe-source-han-sans-jp-fonts
yay -S openssh sshfs alsa-utils xorg-setxkbmap xcape xwallpaper 
yay -S xorg-xinit xorg-server libxinerama libxft scrot
yay -S gimp inkscape blender krita krita-plugin-gmic imagemagick
yay -S zathura zathura-cb zathura-pdf-mupdf
yay -S jack2 ardour x42-plugins lsp-plugins calf eq10q samplv1 synthv1

cd ./dmenu/    && sudo make install clean && cd ..
cd ./dwm/      && sudo make install clean && cd ..
cd ./slstatus/ && sudo make install clean && cd ..
cd ./st/       && sudo make install clean && cd ..

if [ ! -e /usr/share/applications/transmission.desktop ]; then
  echo [Desktop Entry]                 | sudo tee -a /usr/share/applications/transmission.desktop
  echo Name=Transmission               | sudo tee -a /usr/share/applications/transmission.desktop
  echo Type=Application                | sudo tee -a /usr/share/applications/transmission.desktop
  echo Exec=transmission-remote -a %U  | sudo tee -a /usr/share/applications/transmission.desktop
fi

sudo groupadd audio
sudo usermod -a -G audio $USER

if [ ! grep  "@audio - rtprio 90" /etc/security/limits.conf ]; then
  echo "@audio - rtprio 90"      | sudo tee -a /etc/security/limits.conf
  echo "@audio - nice -5"        | sudo tee -a /etc/security/limits.conf
  echo "@audio - memlock 750000" | sudo tee -a /etc/security/limits.conf
fi

xdg-mime default transmission.desktop application/x-bittorrent
xdg-mime default transmission.desktop x-scheme-handler/magnet

xdg-mime default sxiv.desktop image/png
xdg-mime default sxiv.desktop image/jpg
xdg-mime default sxiv.desktop image/jpeg
xdg-mime default sxiv.desktop image/gif
xdg-mime default sxiv.desktop image/bmp

xdg-mime default org.pwmt.zathura.desktop application/pdf
xdg-mime default org.pwmt.zathura.desktop application/epub+zip

cp -r config/* $HOME/.config/
[ -e $HOME/.xinitrc ] || cp config/.xinitrc $HOME/.xinitrc

