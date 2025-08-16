# Oh My Zsh installation path
export ZSH="$HOME/.oh-my-zsh"

# Custom binary path (set early to avoid duplicates)
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Choose a fast, modern theme with rich info (ensure Spaceship is installed)
ZSH_THEME="spaceship"

# Plugins to load — minimal, essential, and popular
plugins=(
  git                  # Essential Git commands and aliases
  z                    # Directory jumping
  fzf                  # Command-line fuzzy finder integration
  alias-tips           # Tips for using your defined aliases
  zsh-autosuggestions  # Suggest commands as you type
  zsh-syntax-highlighting # Syntax highlighting for the shell
  thefuck              # Correct previous command by typing `fuck`
  zsh-completions      # Extra completion definitions for many commands
  history-substring-search # Improved search through your command history by substring
  extract              # Automatic archive extraction with one command
  sudo                 # Quickly rerun last command with sudo
  gitfast              # Faster git status and completions
)


# Disable update checks to speed up startup
DISABLE_AUTO_UPDATE="true"

# Disable compfix to avoid slow startup warnings if safe for your system
DISABLE_COMPFIX="true"

# Disable magic functions if you experience paste issues
DISABLE_MAGIC_FUNCTIONS="true"

# Disable marking untracked files dirty to speed up git prompts in large repos
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Command auto-correction enables typo fixes
ENABLE_CORRECTION="true"

# Show a dot indicator while waiting for completions
COMPLETION_WAITING_DOTS="true"

# History settings for better usability and sharing between terminals
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS      # Ignore duplicate commands in history
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from commands
setopt HIST_VERIFY           # Show command before execution when recalled

# Show report time for commands that run longer than 2 seconds
REPORTTIME=2

# Configure compinit caching to speed up shell startup
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
  compinit
else
  compinit -C
fi

# Configure zsh-autosuggestions settings for async and appearance
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888"

# Source Oh My Zsh last, after all config
source $ZSH/oh-my-zsh.sh

# Load custom aliases if present
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

# Preferred editor settings
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'  # VS Code as default, change to 'nvim' if you prefer Neovim
fi
export VISUAL="$EDITOR"

# Setup Node Version Manager (NVM) with lazy loading for faster startup
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # Lazy load NVM to speed up shell startup
  alias nvm='unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"; nvm $@'
  # Set default node version if .nvmrc doesn't exist
  [ ! -f .nvmrc ] && echo "node" > /tmp/.nvmrc_default
fi
if [ -s "$NVM_DIR/bash_completion" ]; then
  source "$NVM_DIR/bash_completion"
fi

