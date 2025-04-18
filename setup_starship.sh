#!/bin/bash

# Install Starship
echo "Installing Starship..."
curl -sS https://starship.rs/install.sh | sh

# Create configuration directory
CONFIG_DIR="$HOME/.config"
STARSHIP_CONFIG="$CONFIG_DIR/starship.toml"

mkdir -p "$CONFIG_DIR"

# Write configuration
echo "Configuring Starship..."
cat <<EOF > "$STARSHIP_CONFIG"
[prompt]
add_newline = false

[username]
show_always = true

[directory]
truncation_length = 3

[git_branch]
symbol = " "

[time]
format = "[$time]($style) "
EOF

# Apply Starship to bash
echo "Applying Starship configuration..."
SHELL_CONFIG="$HOME/.bashrc"

if [ -f "$SHELL_CONFIG" ]; then
    echo 'eval "$(starship init bash)"' >> "$SHELL_CONFIG"
    source "$SHELL_CONFIG"
    echo "Starship setup complete! Restart your terminal to see the changes."
else
    echo "Couldn't locate ~/.bashrc. Add the following manually:"
    echo 'eval "$(starship init bash)"'
fi
