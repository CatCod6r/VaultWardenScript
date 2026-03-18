# 🛡️ VaultWarden-Deploy
> **The one-command setup for a private, high-performance Vaultwarden instance on Ubuntu 24.04.**


[![Ubuntu 24.04](https://img.shields.io/badge/OS-Ubuntu_24.04-orange?style=flat-square&logo=ubuntu)](https://ubuntu.com/)
[![Docker](https://img.shields.io/badge/Docker-Compose-blue?style=flat-square&logo=docker)](https://www.docker.com/)
[![Nginx](https://img.shields.io/badge/Proxy-Nginx-green?style=flat-square&logo=nginx)](https://nginx.org/)

## 📖 Overview
This repository provides a streamlined, automated deployment for **Vaultwarden** (the lightweight Bitwarden-compatible server). It handles the configuration of an **Nginx Reverse Proxy**, secures the **Docker** environment, and provisions **Let's Encrypt SSL** certificates automatically.

## 🛠️ Prerequisites
* **OS:** Ubuntu 24.04 LTS
* **Hardware:** Minimum 1GB RAM (2GB+ recommended)
* **Network:** Ports **80** and **443** must be open.
* **Domain:** A valid A-Record pointing to your VPS IP.

## 🚀 Deployment Guide

### 1. Initialize Environment
Export your configuration directly to your terminal session(or .env file in the same directory):

```bash
# Your target domain
export DOMAIN_NAME="vault.yourdomain.com"

# Email for SSL registration
export YOURE_EMAIL="admin@yourdomain.com"

# Secure Admin Token (Argon2 formatted)
export VAULTWARDEN_ADMIN_TOKEN=$(echo -n "YourSecret" | argon2 "$(openssl rand -base64 32)" -e -id -k 65540 -t 3 -p 4 | sed 's#\$#\$$#g')
```

### 2. Run Setup
Clone the repository and execute the automation script:

```bash
git clone https://github.com/CatCod6r/VaultWardenScript.git
cd VaultWardenScript
chmod +x setup.sh
./setup.sh
```

### 3. Verification
Once finished, your vault is live at:
* **Vault UI:** `https://your.domain.com`
* **Admin Panel:** `https://your.domain.com/admin`

## 🤝 Troubleshooting
If port 80 or 443 is already in use, run:
`sudo systemctl stop nginx && sudo fuser -k 80/tcp 443/tcp`
Then re-run the setup.
