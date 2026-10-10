#!/usr/bin/env bash

##############################
# Basic Programs
##############################

	# GNOME Core Apps
	flatpak install --noninteractive flathub \
	  org.gnome.Decibels \
	  org.gnome.Calculator \
	  org.gnome.Calendar \
	  org.gnome.Snapshot \
	  org.gnome.clocks \
	  org.gnome.baobab \
	  org.gnome.Papers \
	  org.gnome.Loupe \
	  org.gnome.Logs \
	  org.gnome.TextEditor \
	  org.gnome.Showtime \
	  org.gnome.DejaDup \
	  org.gnome.SimpleScan \
	  
	# Productivity
	flatpak install --noninteractive flathub \
	  app.zen_browser.zen \
	  com.vivaldi.Vivaldi \
	  md.obsidian.Obsidian \
	  org.onlyoffice.desktopeditors \
	  
	# System Utilities
	flatpak install --noninteractive flathub \
	  com.github.tchx84.Flatseal \
	  me.timschneeberger.jdsp4linux \
	  
	flatpak permission-set background background me.timschneeberger.jdsp4linux yes
	mkdir -p ~/.config/autostart
	cp /var/lib/flatpak/exports/share/applications/me.timschneeberger.jdsp4linux.desktop ~/.config/autostart/
	sed -i 's|^Exec=.*|Exec=/bin/sh -c "sleep 5; flatpak run me.timschneeberger.jdsp4linux --tray"|' ~/.config/autostart/me.timschneeberger.jdsp4linux.desktop
	  
	# OpenTabletDriver
	wget https://github.com/OpenTabletDriver/OpenTabletDriver/releases/download/v0.6.5.0/OpenTabletDriver.rpm
	sudo rpm-ostree install OpenTabletDriver.rpm -y
	rm OpenTabletDriver.rpm
	mkdir -p ~/.config/systemd/user/default.target.wants
	ln -sf /usr/lib/systemd/user/opentabletdriver.service \
       	  ~/.config/systemd/user/default.target.wants/opentabletdriver.service

##############################
# Development
##############################

	# Create and Configure Toolbx
	FEDORA_VERSION=$(rpm -E %fedora)
	podman pull registry.fedoraproject.org/fedora-toolbox:$FEDORA_VERSION
	toolbox list | grep -q dev-env || toolbox create --container dev-env
	toolbox run --container dev-env bash -c '
	  sudo dnf install -y git neovim
	  NVM_LATEST_VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
	  curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_LATEST_VERSION}/install.sh" | bash
	  export NVM_DIR="$HOME/.nvm"
	  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	  nvm install node
	  nvm alias default node
	'
	cp -r nvim ~/.config/
	cp resources/run_nvim.sh ~/
	
	# Tools via Flatpak
	flatpak install --noninteractive \
	  flathub io.github.shiftey.Desktop \
	  org.godotengine.Godot \
	  flathub org.gnome.Boxes \
		
##############################
# Design & Creatives
##############################

	flatpak install --noninteractive flathub \
	  org.kde.krita \
	  org.kde.kdenlive \
	  org.audacityteam.Audacity \
	  org.darktable.Darktable \
	  org.blender.Blender
	  
flatpak update --appstream && flatpak update -y
