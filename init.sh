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
# add ssh key for working with github in ~/.ssh/github
# unityhub: https://docs.unity3d.com/hub/manual/InstallHub.html#install-hub-linux
# azure cli: https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?view=azure-cli-latest&pivots=apt

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

sudo wget https://github.com/derailed/k9s/releases/k9s_linux_arm64.deb
sudo apt install k9s_linux_amd64.deb

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

# install uv for python package management
curl -LsSf https://astral.sh/uv/install.sh | sh

# see here for installing qemu: https://github.com/MhouneyLH/zephyr_fhLUG/blob/master/scripts/setup_virtual_machine_management.sh
# create default network for qemu when starting
sudo virsh net-autostart default

# create directory so that unity can save its preferences (somehow it cannot create this directory himself)
# see here for more information: https://www.reddit.com/r/Unity3D/comments/1cqiney/comment/lund5p2/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
mkdir -p ~/.local/share/unity3d
