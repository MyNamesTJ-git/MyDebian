#!/bin/bash
# ==============================================
# Script Name: Comprehensive Debian Maintenance
# Description: Automates maintenance tasks for Debian systems.
# Author: [MyNamesTJ]
# GitHub: [https://github.com/MyNamesTJ-git/MyDebian/]
# ----------------------------------------------
# SETUP INSTRUCTIONS:
# 1. Copy this script to a file named "debhealth.sh".
#    Example: nano ~/debhealth.sh
# 2. Make the script executable:
#    chmod +x ~/debhealth.sh
# 3. Add an alias to your shell configuration to easily run the script:
#    echo "alias debhealth='bash ~/debhealth.sh'" >> ~/.bashrc
# 4. Reload your shell configuration to apply the alias:
#    source ~/.bashrc
# 5. Now, run the script anytime by typing:
#    debhealth
# ----------------------------------------------

echo "Starting comprehensive system maintenance..."
echo "--------------------------------------------"

# Step 1: Update package lists
echo "Updating package lists..."
sudo apt update

# Step 2: Upgrade installed packages
echo "Upgrading packages..."
sudo apt upgrade -y

# Step 3: Full distribution upgrade (for kernel and critical updates)
echo "Applying distribution upgrades..."
sudo apt dist-upgrade -y

# Step 4: Remove unnecessary packages and purge configuration files
echo "Removing unneeded packages..."
sudo apt autoremove --purge -y

# Step 5: Clear old package files and cache
echo "Cleaning cached package files..."
sudo apt autoclean

# Step 6: Fix broken installations
echo "Fixing broken packages..."
sudo dpkg --configure -a
sudo apt install -f

# Step 7: Check package database consistency
echo "Checking package database consistency..."
sudo apt-get check

# Step 8: Verify package integrity
echo "Verifying package integrity..."
if ! command -v debsums &> /dev/null; then
  echo "Installing 'debsums' for integrity checks..."
  sudo apt install debsums -y
fi
sudo debsums -c

# Step 9: Remove orphaned packages (optional but useful)
echo "Removing orphaned packages..."
if ! command -v deborphan &> /dev/null; then
  echo "Installing 'deborphan' to find orphaned packages..."
  sudo apt install deborphan -y
fi
sudo deborphan | xargs sudo apt-get -y remove --purge

# Step 10: Check and clean leftover configuration files
echo "Checking for leftover configuration files..."
sudo dpkg -l | grep '^rc' | awk '{print $2}' | xargs sudo apt-get purge -y

# Step 11: Check system logs for errors
echo "Checking system logs for errors..."
sudo journalctl -p 3 -xb

# Step 12: Clean journal logs (optional, to free up space)
echo "Cleaning old journal logs..."
sudo journalctl --vacuum-time=2weeks

# Step 13: Verify kernel version (to ensure you're running the latest)
echo "Checking kernel version..."
uname -r

echo "--------------------------------------------"
echo "System maintenance completed successfully!"

# Step 14: Ask user if they want to reboot
read -p "Do you want to reboot the system now? (Y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
  echo "Rebooting system..."
  sudo systemctl reboot
else
  echo "Reboot canceled. Remember to reboot manually if necessary."
fi
