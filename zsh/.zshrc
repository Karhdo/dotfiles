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
alias z="cd ~"  # Home directory
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

# Node.js version manager (fnm) setup
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# Zoxide (cd alternative) setup
eval "$(zoxide init zsh)"

# -------------------- Oh-My-Zsh --------------------
# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

# Set theme oh-my-zsh
# ZSH_THEME="robbyrussell"

# Add wisely, as too many plugins slow down shell startup.
# plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

# Source file .zshrc
# source $ZSH/oh-my-zsh.sh

# Customize the zsh Prompt
# PS1="%{$fg[red]%}[%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$fg[red]%}]%{$fg[blue]%} ➜ %{$fg[cyan]%}%c%{$fg[red]%} "
# RPROMPT='$(git_prompt_info)'
