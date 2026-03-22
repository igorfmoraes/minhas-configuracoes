#!/usr/bin/env bash

# Configure Repositories
flatpak remote-delete fedora
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update --appstream

# Remove Unwanted Programs and Upgrade System
sudo rpm-ostree update \
  --uninstall firefox \
  --uninstall firefox-langpacks \
  --uninstall gnome-tour \
  --uninstall gnome-user-docs
flatpak update -y
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update

# Disable NetworkManager wait-online
sudo systemctl disable NetworkManager-wait-online.service

# This Isn't Really Related to Packages
# Zram Configuration

cat <<EOF | sudo tee /etc/sysctl.d/99-zram-tuning.conf > /dev/null
vm.swappiness = 180
vm.page-cluster = 0
vm.watermark_boost_factor = 0
vm.watermark_scale_factor = 125
EOF

cat <<EOF | sudo tee /etc/systemd/zram-generator.conf.d/override.conf > /dev/null
[zram0]
zram-size = ram / 1
compression-algorithm = zstd
swap-priority = 100 
EOF
