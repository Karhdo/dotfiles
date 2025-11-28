# -------------------- Plugins --------------------
source ~/.zsh_custom/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh_custom/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# -------------------- Homebrew --------------------
eval "$(/opt/homebrew/bin/brew shellenv)"

# -------------------- Starship Prompt --------------------
eval "$(starship init zsh)"

# -------------------- FZF --------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

find_files="fd --type f --hidden --follow --exclude .git"
find_directories="fd --type d --hidden --follow --exclude .git"

export FZF_DEFAULT_COMMAND="$find_files"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$find_directories"
export FZF_CTRL_R_OPTS="--no-preview"

export FZF_DEFAULT_OPTS="$(paste -sd' ' ~/.fzf_tokyonight)"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --preview 'bat --color=always {}'"

# Git: checkout branch using fzf
gcof() {
  local branch
  branch=$(git branch --all | sed 's/^[* ] //' | fzf) || return
  branch=${branch#remotes/origin/}
  git checkout "$branch"
}

# -------------------- Bat --------------------
export BAT_THEME="tokyonight_night"

# -------------------- Aliases --------------------
alias c="clear"
alias v="~/Workplace/Karhdo/nvim-macos-arm64/bin/nvim"

alias rz="source ~/.zshrc"
alias cz="cd ~/Workplace/Karhdo/dotfiles && v .zshrc"
alias cv="cd ~/Workplace/Karhdo/dotfiles && v .config/nvim/init.lua"
alias ca="cd ~/.aws && v credentials"

alias zw="cd ~/Workplace"
alias zs="cd ~/Workplace/Spartan"
alias zd="cd ~/Workplace/Karhdo/dotfiles"

alias ls="eza -l --icons"
alias la="eza -la --icons"

# -------------------- Key Bindings --------------------
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# -------------------- PATH --------------------
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="/opt/homebrew/Cellar/go-parquet-tools/1.32.0/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# -------------------- Tools Init --------------------
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(zoxide init zsh)"

# Go
env_path=$(go env GOPATH)/bin
export PATH=$PATH:$env_path

# Java
export JAVA_HOME=$(/usr/libexec/java_home -v17)
export PATH=$JAVA_HOME/bin:$PATH

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
