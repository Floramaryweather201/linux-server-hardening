# Linux Server Hardening & Security Automation

This repository contains infrastructure-as-code automation and compliance auditing tools designed to harden an Ubuntu server environment.

## Features
- **Automated Provisioning:** Dynamically configures secure user groups and assigns roles following the Principle of Least Privilege.
- **Network Defenses:** Hardens SSH configurations (restricts ports, disables root login) and provisions restrictive UFW firewall policies.
- **Compliance Audit Script:** Evaluates local system posture to verify security rule execution.

## How to Run
1. Execute the hardening tool: `sudo ./server_hardening.sh`
2. Run the validation audit: `sudo ./security_audit.sh`
