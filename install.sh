#!/usr/bin/env bash
# Sensible Terminal Setup for macOS

set -e

REPO_HTTPS="https://github.com/jerryjrxie/terminal-setup"
REPO_SSH="git@github.com:jerryjrxie/terminal-setup.git"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.config/terminal-setup}"

echo "Setting up terminal..."

# Install Homebrew if needed
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null)"
fi

# Clone via HTTPS (no auth needed) on first run; on reruns, try to pull but
# don't let an auth failure (e.g. SSH keys not yet set up) abort the script.
if [ -d "$INSTALL_DIR/.git" ]; then
    (cd "$INSTALL_DIR" && git pull --ff-only) || echo "  (git pull skipped — continuing with existing checkout)"
elif [ ! -d "$INSTALL_DIR" ]; then
    git clone "$REPO_HTTPS" "$INSTALL_DIR"
fi
cd "$INSTALL_DIR"

# Install sensible packages
echo "Installing packages..."
brew install zsh-autosuggestions zsh-syntax-highlighting fzf starship eza bat ripgrep fd zoxide atuin mise 2>/dev/null || true

# Setup fzf
echo "Configuring fzf..."
"$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish 2>/dev/null || true

# Install Oh My Zsh — don't let a hiccup here block the symlink below
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc \
        || echo "  (oh-my-zsh install failed — continuing)"
fi

# Install Bun. Its installer appends to ~/.zshrc, but we overwrite that with
# our symlink below — bun PATH/completion is set up by our zshrc instead.
if [ ! -d "$HOME/.bun" ]; then
    echo "Installing Bun..."
    curl -fsSL https://bun.sh/install | bash || echo "  (bun install failed — continuing)"
fi

# Symlink our config — always last, always wins (overwrites any existing file)
ln -sf "$INSTALL_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Switch remote to SSH only after everything else succeeded, so a fresh run
# without SSH keys can't leave the repo unable to pull on the next run.
git remote set-url origin "$REPO_SSH" 2>/dev/null || true

echo "Done! Restart your terminal or run: source ~/.zshrc"
