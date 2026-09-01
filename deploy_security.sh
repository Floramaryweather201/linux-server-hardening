#!/bin/bash
# Quick Automated Linux Security Checklist

echo "======================================"
echo " RUNNING SECURITY AUDIT RECAP "
echo "======================================"

# 1. Check if Root Login over SSH is disabled
if grep -q "^PermitRootLogin no" /etc/ssh/sshd_config; then
    echo "[✔] PASS: Root SSH login is safely disabled."
else
    echo "[✘] FAIL: Root SSH login is ENABLED!"
fi

# 2. Check Firewall Status
if sudo ufw status | grep -q "Status: active"; then
    echo "[✔] PASS: UFW Firewall is active."
else
    echo "[✘] FAIL: Firewall is offline!"
fi

# 3. Check for users with UID 0 (Root privileges)
echo "--------------------------------------"
echo "Users with Root Privileges:"
awk -F: '$3 == 0 {print $1}' /etc/passwd
echo "======================================"
