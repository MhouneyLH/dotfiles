# Dotfiles

This repository contains my personal dotfiles and configuration for various tools and applications I use. The configuration is currently managed using Ansible which is run locally on the machine. I use the config for Laptop and Desktop machines that use Debian 13 as the base OS.

Currently I collected my configuration for:

- KDE Plasma
- Konsole
- shell (zsh)
- base and development tools (terraform, kubectl, docker, kustomize etc.)
- ... of course: AI tools (skills, system prompt etc.)
- other applications I use on a near daily basis

As of now, there are still some steps in the setup that have to be done manually like starting to sync VSCode or Brave Browser settings.

## Installation

Run the following commands to create the setup on your own local machine:

```bash
# Clone the repo
git clone https://github.com/MhouneyLH/dotfiles.git ~/Documents/git/dotfiles
cd ~/Documents/git/dotfiles

# Copy and fill in secrets (GitHub PAT etc.)
cp .env.example .env
vim .env

# Copy and fill in MCP secrets (API keys etc.)
cp config/roles/ai_tools/files/claude/mcp.json.example config/roles/ai_tools/files/claude/mcp.json
vim config/roles/ai_tools/files/claude/mcp.json

sudo ./install.sh

# After install: authenticate Claude Code
claude auth login
```

If only part of the configuration should be applied, run the Ansible playbook with specific tags:

```bash
ansible-playbook config/local.yml -i config/inventory.yml --tags "kde,konsole"
```

## Contributing

About tips, on how to improve the setup, or if you want to share your own configuration, feel free to open an issue or a pull request. Happy Configuring! 🤓🎉
