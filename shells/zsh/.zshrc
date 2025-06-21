# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="amuse"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
zsh-syntax-highlighting
zsh-autosuggestions
you-should-use
zsh-bat
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

# print out the exit code of the last command after the current path in the command line
# we have to override it to write everything from scratch as there is no option in the theme to just configure
# somehting additionally that also gets tracked in this repository
PROMPT='
%{$fg_bold[green]%}%~%{$reset_color%}$(git_prompt_info)$(virtualenv_prompt_info) ⌚ %{$fg_bold[red]%}%*%{$reset_color%}
[%?] $ '

# PATH
export PATH="$PATH:/home/lucas-dev/flutter/bin" # todo: maybe outdated
export PATH="$PATH:/home/lucas-dev/Documents/git/bashtop"
export PATH="$PATH:/home/lucas-dev/.platformio/penv/bin"
export PATH="$PATH:/usr/bin/graphviz"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:/opt/arduino-ide"
export PATH="$PATH:/opt/Postman"
export PATH="$PATH:/home/lucas-dev/.cargo/bin"
export PATH="$PATH:/opt/android-studio/bin"
export PATH="$PATH:$HOME/.dotnet/tools"

# java shit
export JAVA_HOME="/home/lucas-dev/.jdks/openjdk-24.0.1"

# speed of moving with keyboard
timeUntilRepeating=200
repeatRate=30
xset r rate $timeUntilRepeating $repeatRate

# general
alias cdg="cd /home/$USER/Documents/git/"
alias tf="terraform"
alias ..="cd .."
alias ...="cd ..."
alias ....="cd ...."
alias .....="cd ....."
alias grep="grep --color=auto"
alias h="history"
alias cat="batcat"
alias uncorrupt_steam="mv ~/.steam ~/.steam.bak && mv ~/.local/share/Steam ~/.local/share/Steam.bak"
alias dpsn="docker ps --format '{{.Names}}'" # only get names of the running services

# system
alias cleanup="sudo apt autoremove && sudo apt autoclean"
alias update="sudo apt update && sudo apt upgrade"

# programs
alias unity="GDK_SCALE=2 GDK_DPI_SCALE=0.5 /home/$USER/Unity/Hub/Editor/6000.0.33f1/Editor/Unity"
alias unity_feuersim="GDK_SCALE=2 GDK_DPI_SCALE=0.5 /home/$USER/Unity/Hub/Editor/6000.0.33f1/Editor/Unity -projectpath /home/lucas-dev/Documents/git/FeuerSim"
alias dn="dotnet"
alias postman="Postman"

# pnpm
export PNPM_HOME="/home/lucas-dev/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
