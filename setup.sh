#!/bin/bash

source .env

# Installing needed packets
INSTALLED_PACKETS=$(apt list --installed)
if  echo "$INSTALLED_PACKETS" | grep -q "nginx" \
        && echo "$INSTALLED_PACKETS" | grep -q "certbot" \
        && echo "$INSTALLED_PACKETS" | grep -q "python3-certbot-nginx"; then
  echo "All the needed packets already exist"
else
  echo "Installing needed packets"
  sudo apt install -y nginx certbot python3-certbot-nginx
fi

# Configuring nginx
echo "Configuring nginx"

sudo sed "s|DOMAIN_NAME|$DOMAIN_NAME|g" ./vaultwarden.conf \
  | sudo tee /etc/nginx/sites-available/vaultwarden.conf
sudo ln -s /etc/nginx/sites-available/vaultwarden.conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx

# Setting up alertmanager with env value of discord webhook
sudo sed "s|DISCORD_WEBHOOK_URL|$DISCORD_WEBHOOK_URL|g" ./alertmanager/alertmanager.yml.tmp \
  | sudo tee ./alertmanager/alertmanager.yml 

# Configuring Let's Encrypt
echo "Configuring Let's Encrypt"
sudo certbot --nginx -n --agree-tos --email $YOURE_EMAIL -d $DOMAIN_NAME
sudo systemctl enable certbot.timer
