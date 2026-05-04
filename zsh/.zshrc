# Sensible zsh configuration

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # disabled — starship handles the prompt
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Basics
export EDITOR="vi"
export LANG="en_US.UTF-8"

# Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Path
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# Bun
if [ -d "$HOME/.bun" ]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
fi

# mise
if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
if [ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
fi

# Plugins
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Prompt
eval "$(starship init zsh)"

# Better tools
if command -v eza &>/dev/null; then
    alias ls='eza --icons=auto'
    alias ll='eza -la --icons=auto'
fi
if command -v bat &>/dev/null; then
    alias cat='bat --paging=never'
fi
if command -v rg &>/dev/null; then
    alias grep='rg'
fi
if command -v fd &>/dev/null; then
    alias find='fd'
fi
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi
if command -v atuin &>/dev/null; then
    eval "$(atuin init zsh)"
fi

# Safety
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Git shortcuts
alias g="git"
alias gs="git status -sb"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias glog="git log --oneline --graph --decorate -20"

# Navigation
alias ..="cd .."
alias ...="cd ../.."

# Utilities
alias zshrc="$EDITOR ~/.zshrc"
alias reload="source ~/.zshrc"

# Create dir and cd
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Fuzzy git checkout
fbr() {
    git branch -vv | fzf +m | awk '{print $1}' | sed "s/.* //" | xargs git checkout
}

# Load local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
