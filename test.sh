#!/bin/bash

# User input for the app details
read -p "Enter the name of the app: " appname
read -p "Enter the path to the app script: " appscript

# Create a new JSON object for the app
app_json=$(jq -n \
                  --arg name "$appname" \
                  --arg script "$appscript" \
                  '{name: $name, script: $script, env: {}}')

echo $app_json

# Read the PM2 config file
config_json=$(cat pm2.json)

echo $config_json

# Add the new app to the config file
updated_json=$(echo $config_json | jq --argjson new_app "$app_json" '.apps += [$new_app]')

echo $updated_json

# Save the updated config back to the file
echo $updated_json > pm2.json