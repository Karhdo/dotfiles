# -------------------- Oh-My-Zsh --------------------
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set theme oh-my-zsh
ZSH_THEME="robbyrussell"

# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

# Source file .zshrc
source $ZSH/oh-my-zsh.sh

# Customize the zsh Prompt
PS1="%{$fg[red]%}[%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$fg[red]%}]%{$fg[blue]%} ➜ %{$fg[cyan]%}%c%{$fg[red]%} "
RPROMPT='$(git_prompt_info)'

# -------------------- Karhdo's Aliases  -------------------
# Aliases of terminal
alias c="clear"
alias v="nvim"

# Aliases of config
alias cz="cd ~/.config/zsh; v .zshrc" #Config zsh
alias cv="cd ~/.config/nvim; v init.lua" #Config nvim


# Aliases of change directory
alias z="cd ~"
alias zv="cd ~/.config/nvim"
alias zz="cd ~/.config/zsh"
alias zw="cd ~/Workplace"
alias zy="cd ~/Workplace/YouNet-Media"

# Aliases of exa
alias ls="exa -l --icons"
alias la="exa -la --icons"

# Aliases open and split tmux
function ide () {
  if [ -z "$TMUX" ]; then
    # tmux inline speed things up
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

# Tool manager npm versions
eval "$(fnm env --use-on-cd)"

