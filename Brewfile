# Brewfile — install everything with: brew bundle
# (run from the repo root, or: brew bundle --file ~/Workplace/Karhdo/dotfiles/Brewfile)

# --- Core CLI ---
brew "git"
brew "stow"        # symlink manager for these dotfiles
brew "neovim"      # editor (config in .config/nvim)
brew "tmux"        # terminal multiplexer
brew "starship"    # shell prompt
brew "lazygit"     # git TUI (opens files in the parent nvim session)

# --- Shell tooling (.zshrc) ---
brew "bat"         # cat with syntax highlighting + fzf preview
brew "fd"          # fast find, backs fzf file/dir discovery
brew "fzf"         # fuzzy finder
brew "ripgrep"     # used by telescope.nvim live grep
brew "eza"         # ls replacement
brew "fnm"         # Node version manager (auto-switch on cd)
brew "zoxide"      # smarter cd
brew "direnv"      # per-directory env (GH_TOKEN per workspace)
brew "gnupg"       # GPG (commit signing trust)

# --- Languages / LSP runtimes ---
brew "openjdk@21"  # runtime for jdtls + kotlin_lsp (Java/Kotlin LSP)
brew "libpq"       # psql + postgres client libs

# --- Casks ---
cask "wezterm"               # terminal emulator (.wezterm.lua)
cask "font-hack-nerd-font"   # Nerd Font for icons in nvim/eza/starship
