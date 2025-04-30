# HOW TO: first run "git clone https://github.com/MyNamesTJ-git/MyDebian" 
# then run "cd MyDebian"
# finally run "Bash setup.sh"
#!/bin/bash

# Description: Automates the setup of Debian maintenance scripts and sources.list.

echo "Starting setup process..."

# Step 1: Backup existing sources.list
echo "Backing up current /etc/apt/sources.list to /etc/apt/sources.list.bak..."
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Step 2: Install MyRepoFiles.txt as sources.list
echo "Installing new repository list from MyRepoFiles.txt..."
sudo cp MyRepoFiles.txt /etc/apt/sources.list

# Step 3: Notify user about the sources.list update
echo "New repository list has been installed to /etc/apt/sources.list."

# Step 4: Create and install debhealth.sh
echo "Installing debhealth.sh..."
cat << 'EOF' > ~/debhealth.sh
#!/bin/bash
# Comprehensive Debian Maintenance Script
echo "Starting comprehensive system maintenance..."
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
EOF

# Step 5: Make debhealth.sh executable
echo "Making debhealth.sh executable..."
chmod +x ~/debhealth.sh

# Step 6: Add alias to bashrc
echo "Setting up alias 'debhealth'..."
if ! grep -q "alias debhealth=" ~/.bashrc; then
  echo "alias debhealth='bash ~/debhealth.sh'" >> ~/.bashrc
  echo "Alias 'debhealth' added to ~/.bashrc."
else
  echo "Alias 'debhealth' already exists in ~/.bashrc."
fi

# Step 7: Reload bashrc
echo "Reloading shell configuration to apply alias..."
source ~/.bashrc

# Final message
echo "Setup completed successfully! You can now use 'debhealth' to run your maintenance script."
