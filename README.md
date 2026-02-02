# Dotfiles Template

A minimal dotfiles template for use with [OpenBoot](https://openboot.dev).

## Structure

```
dotfiles/
├── git/
│   └── .gitconfig      # Git configuration
├── ssh/
│   └── .ssh/
│       └── config      # SSH configuration
├── zsh/
│   └── .zshrc          # Zsh configuration
└── README.md
```

## Usage

### With OpenBoot

1. Fork this repository
2. Customize the config files
3. Create an OpenBoot config at [openboot.dev/dashboard](https://openboot.dev/dashboard)
4. Set your dotfiles repo URL in the config
5. Run: `curl -fsSL https://openboot.dev/your-username | bash`

### Manual Setup

```bash
# Clone to ~/.dotfiles
git clone https://github.com/YOUR_USERNAME/dotfiles ~/.dotfiles
cd ~/.dotfiles

# Deploy with GNU Stow
stow -v --target="$HOME" git ssh zsh
```

## How It Works

This template uses [GNU Stow](https://www.gnu.org/software/stow/) for symlink management:

- Each top-level directory (git, ssh, zsh) is a "package"
- Files inside are symlinked relative to `$HOME`
- `git/.gitconfig` → `~/.gitconfig`
- `ssh/.ssh/config` → `~/.ssh/config`
- `zsh/.zshrc` → `~/.zshrc`

## Customization

### Adding New Configs

To add a new config (e.g., tmux):

```bash
mkdir -p tmux
touch tmux/.tmux.conf
# Edit tmux/.tmux.conf with your config
stow -v --target="$HOME" tmux
```

### Nested Directories

For configs in subdirectories (like `~/.config/nvim`):

```bash
mkdir -p nvim/.config/nvim
touch nvim/.config/nvim/init.lua
stow -v --target="$HOME" nvim
# Creates: ~/.config/nvim/init.lua
```

## License

MIT
