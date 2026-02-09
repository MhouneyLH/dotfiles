#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y ansible ansible-lint git

ansible-playbook local.yml

