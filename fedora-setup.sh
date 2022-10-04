#!/usr/bin/bash

# Install Rpmfusion repo
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Update cache for package installs
sudo dnf makecache

# grab all packages to install from repos
sudo dnf install $(cat fedora.repopackages) -y

# grab all packages to install from flatpak
sudo flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub $(cat fedora.flatpackages) -y

# enable fish
chsh -s $(which fish)
