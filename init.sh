#!/bin/bash

# Aktualisieren der Paketliste
sudo apt-get update

# Download und Installation von NodeJS LTS Version
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Download und Installation von nginx
sudo apt-get install -y nginx

# Download und Installation von certbot für nginx
sudo apt-get install -y certbot python3-certbot-nginx

# Download und Installation von jq
sudo apt-get install -y jq

# Download und Installation von PM2 npm package
sudo npm install pm2@latest -g