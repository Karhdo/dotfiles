# -------------------- ZSH Plugins --------------------
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh  # Command suggestions
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # Command syntax highlighting

# -------------------- Starship Prompt --------------------
eval "$(starship init zsh)"  # Initializes Starship prompt

# -------------------- Aliases --------------------
# Terminal Aliases
alias c="clear"
alias v="~/Downloads/nvim-macos-x86_64/bin/nvim"

# Configuration Aliases
alias cz="cd ~/.config/zsh && v .zshrc"  # Edit Zsh config
alias cv="cd ~/.config/nvim && v init.lua"  # Edit Neovim config

# Directory Navigation Aliases
alias zv="cd ~/.config/nvim"  # Neovim config folder
alias zz="cd ~/.config/zsh"  # Zsh config folder
alias zw="cd ~/Workplace"  # Workplace folder
alias zy="cd ~/Workplace/YouNet_Media"  # YouNet Media folder

# Exa (ls alternative) Aliases
alias ls="exa -l --icons"  # List with icons
alias la="exa -la --icons"  # List all with icons

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
bindkey '^[[A' history-search-backward  # Search history backward
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
