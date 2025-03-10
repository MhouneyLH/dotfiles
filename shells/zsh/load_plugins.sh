#!/bin/zsh

# Define the list of repositories to clone
REPOS=(
    "https://github.com/zsh-users/zsh-autosuggestions"
    "https://github.com/zsh-users/zsh-syntax-highlighting"
    "https://github.com/MichaelAquilina/zsh-you-should-use"
    "https://github.com/fdellwing/zsh-bat"
)

# Set the directory where the repositories should be cloned
CLONE_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
mkdir -p "$CLONE_DIR"

# Clone each repository
for REPO in "${REPOS[@]}"; do
    REPO_NAME=$(basename "$REPO" .git)
    if [ -d "$CLONE_DIR/$REPO_NAME" ]; then
        echo "$REPO_NAME already exists, skipping..."
    else
        echo "Cloning $REPO_NAME..."
        git clone "$REPO" "$CLONE_DIR/$REPO_NAME"
    fi
done

# Update .zshrc to include the plugins
ZSHRC="$HOME/.zshrc"
PLUGINS_LINE="plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use zsh-bat)"
if grep -q "^plugins=" "$ZSHRC"; then
    sed -i '' "s/^plugins=.*/$PLUGINS_LINE/" "$ZSHRC"
else
    echo "$PLUGINS_LINE" >> "$ZSHRC"
fi

# Reload Zsh configuration
source "$ZSHRC"

echo "\nDone! Add the following plugins to your .zshrc file:"
echo "plugins=(git $(basename -a "${PLUGINS[@]}"))"
