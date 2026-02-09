#!/usr/bin/env bash

# Load environment variables if .env file exists
if [ -f .env ]; then
    echo "Loading environment variables from .env..."
    source .env
else
    echo "Warning: .env file not found. Git configuration will be skipped."
    echo "Copy .env.example to .env and fill in your details if you want git config."
fi

sudo apt-get update
sudo apt-get install -y ansible ansible-lint git

ansible-playbook local.yml

