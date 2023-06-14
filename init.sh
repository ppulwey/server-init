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

# Download und Installation von PM2 npm package
sudo npm install pm2@latest -g

# Abfrage einer Domain
echo "Bitte geben Sie Ihre Domain ein:"
read domain

# Abfrage eines Ports
echo "Bitte geben Sie den Port ein, auf dem Ihr Anwendung läuft:"
read port

http_upgrade='$http_upgrade'
host='$host'

# Einrichten eines Reverseproxy Eintrages in nginx für localhost und den eingegebenen Port
sudo bash -c "cat > /etc/nginx/sites-available/$domain <<EOF
server {
    listen 80;
    server_name $domain;

    location / {
        proxy_pass http://localhost:$port;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
EOF"

# Symlink erstellen, um die Konfiguration zu aktivieren
sudo ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/

# Testen der nginx-Konfiguration und Neustart von nginx
sudo nginx -t && sudo service nginx restart

# Certbot für die Domain einrichten
sudo certbot --nginx -d $domain -d www.$domain
