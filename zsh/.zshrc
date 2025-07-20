# -------------------- ZSH Plugins --------------------
source ~/.zsh_custom/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh_custom/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Homebrew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# -------------------- Starship Prompt --------------------
eval "$(starship init zsh)"  # Initializes Starship prompt

# -------------------- Aliases --------------------
# Terminal Aliases
alias c="clear"
alias v="~/Workplace/Karhdo/nvim-macos-arm64/bin/nvim"

# Configuration Aliases
alias cz="cd ~/.config/zsh && v .zshrc"    # Edit Zsh config
alias rz="source ~/.config/zsh/.zshrc"     # Reload Zsh config
alias cv="cd ~/.config/nvim && v init.lua" # Edit Neovim config
alias ca="cd ~/.aws && v credentials"      # Edit AWS credentials

# Directory Navigation Aliases
alias zv="cd ~/.config/nvim"      # Neovim config folder
alias zz="cd ~/.config/zsh"       # Zsh config folder
alias zw="cd ~/Workplace"         # Workplace folder
alias zs="cd ~/Workplace/Spartan" # Spartan folder

# Exa (ls alternative) Aliases
alias ls="eza -l --icons"  # List with icons
alias la="eza -la --icons" # List all with icons

# -------------------- Functions --------------------
# Open Tmux IDE layout
function ide() {
  if [ -z "$TMUX" ]; then
    tmux new-session \; \
      split-window -v -l 22%\; \
      split-window -h -l 50%\; \
      select-pane -t 0
  else
    tmux split-window -v -l 22%\; \
      split-window -h -l 50%\; \
      select-pane -t 0
  fi
}

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

export PATH=$PATH:$(go env GOPATH)/bin

export JAVA_HOME=$(/usr/libexec/java_home -v17)
# export JAVA_HOME=$(/usr/libexec/java_home -v1.8)
export PATH=$JAVA_HOME/bin:$PATH

export PATH="/opt/homebrew/Cellar/go-parquet-tools/1.32.0/bin:$PATH"

export PATH="/usr/local/bin:$PATH"
