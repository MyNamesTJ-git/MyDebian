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
# (Insert the full debhealth.sh script content here)
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
