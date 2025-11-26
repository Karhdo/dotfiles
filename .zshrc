# -------------------- ZSH Plugins --------------------
source ~/.zsh_custom/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh_custom/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Homebrew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# -------------------- Starship Prompt --------------------
eval "$(starship init zsh)"  # Initializes Starship prompt

# -------------------- FZF Setup --------------------
# Adds fzf to path & sets up key bindings and fzf completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use fd instead of find for fzf, for speed, better syntax & ignore .gitignore files by default
find_files="fd --type f --hidden --follow --exclude .git"
find_directories="fd --type d --hidden --follow --exclude .git"

export FZF_DEFAULT_COMMAND="$find_files"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$find_directories"
export FZF_CTRL_R_OPTS="--no-preview"

# Config fzf with tokyonight theme
export FZF_DEFAULT_OPTS="$(paste -sd' ' ~/.fzf_tokyonight)"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --preview 'bat --color=always {}'"

# Checkout Git branch using fzf
gcof() {
  local branch
  branch=$(git branch --all | sed 's/^[* ] //' | fzf) || return
  branch=${branch#remotes/origin/}
  git checkout "$branch"
}

# -------------------- Bat Setup --------------------
export BAT_THEME="tokyonight_night"

# -------------------- Aliases --------------------
# Terminal Aliases
alias c="clear"
alias v="~/Workplace/Karhdo/nvim-macos-arm64/bin/nvim"

# Configuration Aliases
alias rz="source ~/.zshrc"                                           # Reload Zsh config
alias cz="cd ~/Workplace/Karhdo/dotfiles && v .zshrc"                # Edit Zsh config
alias cv="cd ~/Workplace/Karhdo/dotfiles && v .config/nvim/init.lua" # Edit Neovim config
alias ca="cd ~/.aws && v credentials"                                # Edit AWS credentials

# Directory Navigation Aliases
alias zw="cd ~/Workplace"                 # Workplace folder
alias zs="cd ~/Workplace/Spartan"         # Spartan folder
alias zd="cd ~/Workplace/Karhdo/dotfiles" # Dotfiles folder

# Exa (ls alternative) Aliases
alias ls="eza -l --icons"  # List with icons
alias la="eza -la --icons" # List all with icons

# -------------------- Key Bindings --------------------
bindkey '^[[A' history-search-backward # Search history backward
bindkey '^[[B' history-search-forward  # Search history forward

# -------------------- Environment Variables --------------------
# Add Cargo binaries to PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Add local binaries to PATH
export PATH="$HOME/.local/bin:$PATH"

# Add Neovim Mason binaries to PATH
export PATH=$HOME/.local/share/nvim/mason/bin:$PATH

# Node.js version manager (fnm) setup
eval "$(fnm env --use-on-cd --shell zsh)"

# Zoxide (cd alternative) setup
eval "$(zoxide init zsh)"

# Go environment setup
export PATH=$PATH:$(go env GOPATH)/bin

# Java environment setup
export JAVA_HOME=$(/usr/libexec/java_home -v17)
# export JAVA_HOME=$(/usr/libexec/java_home -v1.8)
export PATH=$JAVA_HOME/bin:$PATH

# Parquet tools setup
export PATH="/opt/homebrew/Cellar/go-parquet-tools/1.32.0/bin:$PATH"

# Add /usr/local/bin to PATH for compatibility
export PATH="/usr/local/bin:$PATH"

# pyenv environment setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
