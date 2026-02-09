# Dotfiles

This repository contains my personal dotfiles and configuration for various tools and applications I use. The configuration is currently managed using Ansible which is run locally on the machine. I use the config for Laptop and Desktop machines that use Debian 13 as the base OS.

Currently I collected my configuration for:

- KDE Plasma
- Konsole
- shell (zsh)
- base and development tools
- other applications I use on a near daily basis

As of now, there are still some steps in the setup that have to be done manually like starting to sync VSCode or Brave Browser settings.

## Installation

Run the following commands to create the setup on your own local machine:

```bash
cd config

# Copy and edit the environment file with your personal details
# and edit with information
cp .env.example .env

./install.sh
```

## Contributing

About tips, on how to improve the setup, or if you want to share your own configuration, feel free to open an issue or a pull request. Happy Configuring! 🤓🎉
