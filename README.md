# Terminal Setup

> Sensible terminal configuration for macOS

One-command setup for a better terminal experience.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/jerryjrxie/terminal-setup/main/install.sh | bash
```

## What You Get

- **zsh-autosuggestions** — Command suggestions as you type
- **zsh-syntax-highlighting** — Real-time syntax validation
- **fzf** — Fuzzy finder (`Ctrl+T`, `Ctrl+R`)
- **starship** — Clean, fast prompt
- **eza** — Better `ls` with icons
- **bat** — Syntax-highlighted `cat`
- **ripgrep** — Fast `grep`
- **fd** — Fast `find`

## Key Bindings

- `Ctrl+T` — Find files
- `Ctrl+R` — Search history
- Type to see suggestions

## Aliases

```bash
ls → eza      # Better ls with icons
cat → bat     # Syntax highlighted
grep → rg     # Fast grep
find → fd     # Fast find
g → git       # Git shortcut
.. → cd ..    # Parent directory
```

## Customization

Add your own settings to `~/.zshrc.local`:

```bash
export API_KEY="secret"
alias vpn="open /Applications/VPN.app"
```

## Requirements

- macOS
- Homebrew (installed automatically if missing)

## License

MIT
