#!/usr/bin/bash

# Set hostname
sudo hostnamectl set-hostname --static "macro"

# Install Rpmfusion repo
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Update cache for package installs
sudo dnf makecache

# grab all packages to install from repos
sudo dnf install $(cat fedora.repopackages) -y

# grab all packages to install from flatpak
sudo flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub $(cat fedora.flatpackages) -y

# enable zsh
chsh -s $(which zsh)

# setup flutter 
mkdir -p $HOME/Dev
cd $HOME/Dev
wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.0.0-stable.tar.xz
tar xf flutter_linux_v1.0.0-stable.tar.xz
echo export PATH=$HOME/Dev/flutter/bin:$PATH >> ~/.bashrc
rm flutter_linux_v1.0.0-stable.tar.xz

# setup Android Home
mkdir -p $HOME/Dev/Android/Sdk
echo export ANDROID_HOME=$HOME/Dev/Android/Sdk >> ~/.bashrc
