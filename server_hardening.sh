# Add group to sudoers configuration securely
SUDOERS_FILE="/etc/sudoers.d/sec-admins"
if [ ! -f "$SUDOERS_FILE" ]; then
    echo "%sec-admins ALL=(ALL:ALL) ALL" > "$SUDOERS_FILE"
    chmod 0440 "$SUDOERS_FILE"
    echo "  - Added sec-admins group to sudoers privileges."
fi

# 2. Hardening SSH Configuration
echo "[+] Hardening SSH configuration..."
SSH_CONF="/etc/ssh/sshd_config"

# Backup original config just in case
cp "$SSH_CONF" "${SSH_CONF}.bak"

# Use sed to find and update or append security configurations
sed -i 's/^#\?Port .*/Port 2222/' "$SSH_CONF"
sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin no/' "$SSH_CONF"
sed -i 's/^#\?MaxAuthTries .*/MaxAuthTries 3/' "$SSH_CONF"

# Restart service to apply changes
systemctl restart sshd
echo "  - SSH port shifted to 2222, Root login disabled."

# 3. Configure Firewall Rules (UFW)
echo "[+] Configuring UFW Firewall..."
ufw --force reset > /dev/null
ufw default deny incoming > /dev/null
ufw default allow outgoing > /dev/null
ufw allow 2222/tcp > /dev/null
echo "y" | ufw enable > /dev/null
echo "  - Firewall active. Only traffic to port 2222 is allowed."

echo "=========================================="
echo "          HARDENING COMPLETE!             "
echo "=========================================="
