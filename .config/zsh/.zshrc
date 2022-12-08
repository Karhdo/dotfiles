# -------------------- Oh-My-Zsh --------------------
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set theme oh-my-zsh
ZSH_THEME="robbyrussell"

# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# Customize the zsh Prompt
#PS1="%{$fg[red]%}[%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[cyan]%}%c%{$fg[red]%}] %{$fg[blue]%}➜ "
PS1="%{$fg[red]%}[%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$fg[red]%}]%{$fg[blue]%} ➜ %{$fg[cyan]%}%c%{$fg[red]%} "
RPROMPT='$(git_prompt_info)'
# -------------------- Command-line Fuzzy Finder --------------------
# Path to your fzf installation.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# -------------------- User Aliases  -------------------
# Aliases of termial
alias c="clear"
alias v="nvim"

# Aliases of config
alias cz="nvim ~/.config/zsh/.zshrc" #Config zsh
alias cv="nvim ~/.config/nvim/init.lua" #Config nvim

#Aliases of change directory
alias z="cd ~"
alias zv="cd ~/.config/nvim"
alias zqk="cd ~/Workplace/QK-IT\ Company"

#Aliases of exa
alias ls="exa -l --icons"
alias la="exa -la --icons"

# Tool manager npm versions
eval "$(fnm env --use-on-cd)"

export PATH="$PATH:/usr/local/mongodb/bin"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"


