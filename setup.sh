# HOW TO: first run "git clone https://github.com/MyNamesTJ-git/MyDebian" 
# then run "cd MyDebian"
# finally run "Bash setup.sh"
#!/bin/bash

# Description: Automates installation of the debhealth script, including file creation and alias setup.

echo "Installing debhealth script..."

# Step 1: Create the debhealth script file
cat << 'EOF' > ~/debhealth.sh
#!/bin/bash
# Comprehensive Debian Maintenance Script
echo "Starting comprehensive system maintenance..."
# (Include the full debhealth script content here)
EOF

echo "Script debhealth.sh created!"

# Step 2: Make the script executable
chmod +x ~/debhealth.sh
echo "Script made executable!"

# Step 3: Add alias to bashrc
if ! grep -q "alias debhealth=" ~/.bashrc; then
  echo "alias debhealth='bash ~/debhealth.sh'" >> ~/.bashrc
  echo "Alias debhealth added to ~/.bashrc!"
else
  echo "Alias debhealth already exists in ~/.bashrc!"
fi

# Step 4: Reload bashrc
source ~/.bashrc
echo "Shell configuration reloaded!"

echo "Setup complete. Run 'debhealth' to execute the script!"
