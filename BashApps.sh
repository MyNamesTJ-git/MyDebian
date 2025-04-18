#!/bin/bash

# Update package lists and fix missing files
sudo apt update --fix-missing && sudo apt upgrade -y --fix-missing

# Install necessary console tools & LibreOffice with --reinstall
sudo apt install --reinstall -y alacritty thunar synaptic neofetch htop code neovim \
featherpad feh mpv curl mupdf git build-essential tmux zsh fzf ncdu ripgrep bat libreoffice --fix-missing

# Install Brave Browser via official script
curl -fsS https://dl.brave.com/install.sh | sh

# Remove unwanted KDE applications
sudo apt remove -y kmail konqueror kdevelop korganizer kget kaddressbook knotes kcalc

# Clean up unnecessary dependencies
sudo apt autoremove -y
sudo apt clean

echo "Setup complete! Your ThinkPad is now configured."
