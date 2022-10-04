#!/usr/bin/bash

# DNF Config
echo "max_parallel_downloads=20
defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf

# Install Rpmfusion repo
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Update cache for package installs
sudo dnf makecache

# Enable COPRs
sudo dnf copr enable -y atim/bottom
sudo dnf copr enable -y atim/zoxide 
sudo dnf copr enable -y varlad/helix

# grab all packages to install from repos
sudo dnf install $(cat fedora.repopackages) -y

# Compile and install Cargo packages
echo "export PATH=/home/$USER/.cargo/bin:$PATH" >> cargo.sh && move ./cargo.sh /etc/profile.d/
cargo install xplr zellij exa trashy dust

# grab all packages to install from flatpak
sudo flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub $(cat fedora.flatpackages) -y

# enable fish
chsh -s $(which fish)
