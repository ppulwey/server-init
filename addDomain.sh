# Author: Patrick Pulwey

appPath="/var/meeploy/apps"
pm2ConfigPath="/var/meeploy/pm2.config.json"

# Check if app path is available. If not create it.
if [ ! -d "$appPath" ]; then
    sudo mkdir $appPath
fi

# Check if the pm2 config file is available. If not create it.
if [ ! -f "$pm2ConfigPath" ]; then
    sudo bash -c "cat > $pm2ConfigPath <<EOF
{
    \"apps\": []
}

# Enter app name
echo "Please enter the name of your app:"
read appname


# Check if appname is already in use
if [ -d "$appPath/$appname" ]; then
    echo "Appname already in use. Please choose another one."
    exit 1
fi

# Create app folder
sudo mkdir $appPath/$appname

appScript="$appPath/$appname/index.js"

# Enter domain
echo "Please enter the domain you want to register:"
read domain

# Enter port
echo "Please enter the port your app will be running on:"
read port

http_upgrade='$http_upgrade'
host='$host'

# Crate reverse proxy configuration for nginx
sudo bash -c "cat > /etc/nginx/sites-available/$domain <<EOF
server {
    listen 80;
    server_name $domain;

    location / {
        proxy_pass http://localhost:$port;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \\$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \\$host;
        proxy_cache_bypass \\$http_upgrade;
    }
}
EOF"

# Create symlink for reverse proxy configuration
sudo ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/

# Test and restart nginx
sudo nginx -t && sudo service nginx restart

# Create certbot certificate
sudo certbot --nginx -d $domain

echo "Domain $domain registered successfully!"

# Create a new JSON object for the app
app_json=$(jq -n \
                  --arg name "$appname" \
                  --arg script "$appScript" \
                  '{name: $name, script: $script, env: {"NODE_ENV": "production"}}')

# Read the PM2 config file
config_json=$(cat $pm2ConfigPath)

# Add the new app to the config file
updated_json=$(echo $config_json | jq --argjson new_app "$app_json" '.apps += [$new_app]')

# Save the updated config back to the file
echo $updated_json > $pm2ConfigPath