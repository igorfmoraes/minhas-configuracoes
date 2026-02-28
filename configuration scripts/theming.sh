#!/usr/bin/env bash

mkdir -p customization
cd customization

# Accent color
gsettings set org.gnome.desktop.interface accent-color slate

# Mignon Icons
git clone https://github.com/IgorFerreiraMoraes/Mignon-icon-theme.git
cd Mignon-icon-theme
./install.sh --dest "$HOME/.icons"
gsettings set org.gnome.desktop.interface icon-theme "Mignon-pastel"
cd ..

# Graphite Cursor Theme
git clone https://github.com/vinceliuice/Graphite-cursors.git
cd Graphite-cursors
./install.sh --dest "$HOME/.icons"
gsettings set org.gnome.desktop.interface cursor-theme "Graphite-dark-nord-cursors"
cd ..

# Firefox Theme
curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash

# Terminal
gsettings set org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/$PTYXIS_PROFILE/ palette nord
gsettings set org.gnome.Ptyxis interface-style light

# Background
gsettings set org.gnome.desktop.background picture-uri resources/bg.jpg
gsettings set org.gnome.desktop.background picture-uri-dark resources/bg.jpg

cd ..
rm -rf customization

