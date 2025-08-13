# Modern macOS Dotfiles

An optimized dotfiles configuration for macOS with Zsh, Oh My Zsh, and modern CLI tools.

## Features

- **Zsh configuration** with Oh My Zsh and Spaceship theme
- **Performance optimized** with lazy loading and careful plugin selection
- **Modern CLI tools** replacing standard Unix utilities with faster, more user-friendly alternatives
- **Sensible macOS defaults** for better user experience
- **Development-focused** with Git aliases, Node.js support, and editor configuration

## Quick Setup

### 1. Install Prerequisites
```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Spaceship theme
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

### 2. Install Dotfiles
```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 3. Install Modern CLI Tools
```bash
./brew.sh
```

### 4. Apply macOS Settings
```bash
./mac-defaults.sh
```

### 5. Setup Shell Configuration
```bash
# Backup existing files
cp ~/.zshrc ~/.zshrc.backup 2>/dev/null || true
cp ~/.zsh_aliases ~/.zsh_aliases.backup 2>/dev/null || true

# Link new configuration
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.zsh_aliases ~/.zsh_aliases

# Restart your terminal or run:
source ~/.zshrc
```

## What's Included

### Zsh Configuration (`.zshrc`)
- **Spaceship theme** for a beautiful, informative prompt
- **Optimized plugins** for Git, fuzzy finding, autosuggestions, and more
- **Performance tuning** with compinit caching and lazy NVM loading
- **Smart history** with deduplication and sharing between sessions

### Modern CLI Tools (`brew.list`)
- `bat` - Better `cat` with syntax highlighting
- `exa` - Better `ls` with colors and Git status
- `ripgrep` - Much faster `grep` replacement
- `fd` - Better `find` replacement
- `zoxide` - Modern directory jumping
- `fzf` - Fuzzy finder for everything
- And many more productivity tools

### Aliases (`.zsh_aliases`)
- Modern tool shortcuts (`ls` → `exa`, `cat` → `bat`)
- Git workflow aliases (`gs`, `ga`, `gc`, etc.)
- System utilities and network commands
- Safety nets for destructive commands

### macOS Settings (`mac-defaults.sh`)
- Finder optimizations
- Developer-friendly defaults
- Security and privacy improvements
- Performance enhancements

## Customization

Feel free to modify any configuration files to match your preferences:

- **Editor**: Change `EDITOR` in `.zshrc` (currently set to VS Code)
- **Theme**: Modify Spaceship theme settings
- **Plugins**: Add/remove Oh My Zsh plugins as needed
- **Aliases**: Customize `.zsh_aliases` for your workflow

## Maintenance

```bash
# Update Homebrew packages
brew update && brew upgrade && brew cleanup

# Update Oh My Zsh
omz update

# Update plugins manually or use Oh My Zsh's update system
```

## Troubleshooting

If you experience slow shell startup:
1. Check which plugins are taking time with `time zsh -c exit`
2. Consider removing unused plugins
3. Ensure NVM lazy loading is working properly

## Contributing

Feel free to suggest improvements or submit pull requests!
