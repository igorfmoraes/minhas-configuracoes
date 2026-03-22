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

# Terminal
gsettings set org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/$PTYXIS_PROFILE/ palette nord
gsettings set org.gnome.Ptyxis interface-style light

# Background
cp -n resources/bg.jpg $HOME/.local/share/backgrounds/
gsettings set org.gnome.desktop.background picture-uri file://$HOME/.local/share/backgrounds/bg.jpg
gsettings set org.gnome.desktop.background picture-uri-dark file://$HOME/.local/share/backgrounds/bg.jpg

# Stuff
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
dconf load / < resources/gnome-nav.ini

cd ..
rm -rf customization

