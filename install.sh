#!/usr/bin/env bash
# Sensible Terminal Setup for macOS

set -e

REPO_URL="https://github.com/jerryjrxie/terminal-setup"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.config/terminal-setup}"

echo "Setting up terminal..."

# Install Homebrew if needed
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null)"
fi

# Clone or update repo
if [ -d "$INSTALL_DIR" ]; then
    cd "$INSTALL_DIR" && git pull
else
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# Install sensible packages
echo "Installing packages..."
brew install zsh-autosuggestions zsh-syntax-highlighting fzf starship eza bat ripgrep fd zoxide atuin 2>/dev/null || true

# Setup fzf
echo "Configuring fzf..."
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish 2>/dev/null || true

# Install Oh My Zsh first so any .zshrc it creates gets caught by the backup below
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

# Backup any plain-file .zshrc (including one oh-my-zsh may have just written)
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d)"
fi

# Symlink our config — always last, always wins
ln -sf "$INSTALL_DIR/zsh/.zshrc" "$HOME/.zshrc"

echo "Done! Restart your terminal or run: source ~/.zshrc"
