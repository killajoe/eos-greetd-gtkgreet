#!/bin/bash
# EndeavourOS setup for greetd and ReGreet

# --- CONFIGURATION ---
# GitHub Raw links for config files
REPO_RAW_URL="https://raw.githubusercontent.com/killajoe/eos-greetd-regreet/refs/heads/main/"
GREETD_CONF_URL="$REPO_RAW_URL/config.toml"
REGREET_CONF_URL="$REPO_RAW_URL/regreet.toml"

# --- 1. PACKAGE INSTALLATION ---
echo "Installing required packages (greetd, ReGreet, cage)..."
pacman -S --needed --noconfirm greetd greetd-regreet cage

# --- 2. PREPARE DIRECTORIES ---
echo "Preparing configuration directories..."
sudo mkdir -p /etc/greetd

# --- 3. DOWNLOAD CONFIGS (wget) ---
echo "Downloading configuration files from GitHub..."

# -q: quiet, -O: Output file destination
wget -q "$GREETD_CONF_URL" -O /etc/greetd/config.toml
wget -q "$REGREET_CONF_URL" -O /etc/greetd/regreet.toml

# Check if downloads were successful
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to download configuration files!"
    exit 1
fi

# --- 4. PERMISSIONS & GROUPS ---
echo "Setting permissions for the greeter user..."

# Ensure hardware acceleration for the compositor (cage)
usermod -aG video,render greeter

# Ensure the greeter user can read the downloaded files
chown -R greeter:greeter /etc/greetd/
chmod 644 /etc/greetd/config.toml
chmod 644 /etc/greetd/regreet.toml

# --- 5. SERVICE ACTIVATION ---
echo "Disabling any other Display Managers and enabling greetd..."

# -f option will replace with any existing DMs if they exist

systemctl -f enable greetd.service

echo "-----------------------------------------------------------------"
echo "Installation complete! ReGreet for EndeavourOS is now configured."
echo "-----------------------------------------------------------------"
