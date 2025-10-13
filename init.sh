#!/bin/bash


# Manual steps that are needed

# adjusting keyboad configuration (especially on laptp)
# scroll direction
# maybe there is a way to sync this kde configuration somehow 
# adjust theme
# adjust scrolling (activate natural scrolling)
# follow: https://code.visualstudio.com/docs/setup/linux
# key repetitions
# follow: https://docs.docker.com/engine/install/debian/
# start syncing settings in brave
# download deb from here: https://obsidian.md/download
# had some quirks with network configuration outside of home (after some investigation, NetworkManager configurations and a reboot, it somehow started working again) + also installed firmware stuff

sudo su
sudo adduser -aG sudo lucas-dev

reboot
sudo apt-get install nala
curl -fsS https://dl.brave.com/install.sh | sh

sudo nala install curl zsh -y

wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo nala install ./gitkraken-amd64.deb

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# clone all repositories needed
~/Documents/git/dotfiles/shells/zsh/load_plugins.sh
rm -rf ~/.zshrc
ln -s ~/Documents/git/dotfiles/shells/zsh/.zshrc ~/.zshrc

chsh -s $(which zsh) # is applied after reboot

 sudo groupadd docker
sudo usermod -aG docker $USER

sudo nala install nodejs npm -y
sudo npm install -g pnpm@latest-10

sudo nala install vim rename gh -y
