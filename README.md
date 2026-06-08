# Karhdo's dotfiles

![nvim screenshot](./images/screenshot-neovim.png)

Personal macOS dotfiles. The repo root mirrors `$HOME` and is symlinked with [GNU Stow](https://www.gnu.org/software/stow/).

## Contents

- [Fresh machine setup](#fresh-machine-setup)
- [Updating](#updating)
- [Neovim](#neovim)
- [Tmux](#tmux)
- [Lazygit](#lazygit)
- [Git](#git)
- [Wezterm](#wezterm)
- [Shell](#shell)
- [Bat](#bat)
- [Reference](#reference)

## Fresh machine setup

Run these in order on a brand-new macOS machine. Most steps are copy-paste.

### 1. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Clone this repo

```bash
git clone https://github.com/Karhdo/dotfiles ~/Workplace/Karhdo/dotfiles
cd ~/Workplace/Karhdo/dotfiles
```

### 3. Install packages

Everything is declared in the [`Brewfile`](Brewfile):

```bash
brew bundle
```

### 4. Symlink the dotfiles

```bash
stow -t ~ .
```

`.stow-local-ignore` keeps repo-only files (`README.md`, `CLAUDE.md`, `Brewfile`, `images/`, `.git`, …) out of `$HOME`. Re-run with `stow -R -t ~ .` after adding new top-level files.

### 5. Shell plugins & integrations

```bash
# zsh plugins (sourced by .zshrc, not vendored here)
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh_custom/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh_custom/zsh-syntax-highlighting

# fzf key bindings + completion -> creates ~/.fzf.zsh
"$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc
```

### 6. Tmux plugin manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then start tmux and press `C-t I` (prefix + I) to install plugins.

### 7. Bat themes

Theme sources are third-party clones (not tracked):

```bash
git clone https://github.com/0xTadash1/bat-into-tokyonight ~/.config/bat/bat-into-tokyonight
git clone https://github.com/folke/tokyonight.nvim ~/.config/bat/themes/tokyonight.nvim
bat cache --build
```

### 8. Java toolchain (for jdtls / kotlin LSP)

`brew install openjdk@21` is keg-only; register it so `/usr/libexec/java_home -v 21` (used in `.zshrc`) can find it:

```bash
sudo ln -sfn /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk \
  /Library/Java/JavaVirtualMachines/openjdk-21.jdk
```

### 9. Git identity (see [Git](#git) for details)

```bash
# Personal identity — NOT tracked in this repo
cat > ~/.gitconfig-karhdo <<'EOF'
[user]
    name = Karhdo
    email = karhdo.trong@gmail.com
    signingkey = ~/.ssh/karhdo.pub
EOF
```

Also set up `~/.ssh/config`, your SSH keys, `~/.ssh/allowed_signers`, and per-workspace `.envrc` files — all covered in the [Git](#git) section.

### 10. Reload & finish

```bash
source ~/.zshrc          # or open a new terminal
```

Launch Neovim once (`nvim` / `v`): [lazy.nvim](https://github.com/folke/lazy.nvim) bootstraps itself and installs all plugins, and [mason](https://github.com/williamboman/mason.nvim) pulls LSP servers/formatters automatically.

Finally, set your terminal font to **Hack Nerd Font** (installed via the Brewfile).

> The old standalone Neovim under `~/Workplace/Karhdo/nvim-macos-arm64/` is no longer used — config now relies on `brew install neovim`. You can delete that directory.

## Updating

```bash
brew bundle                 # install any newly added packages
stow -R -t ~ .              # re-link after adding top-level files
```

- Reload shell: `rz`
- Edit `.zshrc` / `init.lua`: `cz` / `cv`
- Neovim plugin versions are pinned in [.config/nvim/lazy-lock.json](.config/nvim/lazy-lock.json); commit it after `:Lazy sync`/`:Lazy update`.

## Neovim

Requires [Neovim](https://neovim.io/) **>= 0.11** (tested on 0.12.1).

- Entry point: [.config/nvim/init.lua](.config/nvim/init.lua) → loads `karhdo.core`, `karhdo.lazy`, `karhdo.lsp`.
- Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim) — specs auto-imported from [.config/nvim/lua/karhdo/plugins/](.config/nvim/lua/karhdo/plugins/).
- LSP tooling via [mason.nvim](https://github.com/williamboman/mason.nvim); formatters via [conform.nvim](https://github.com/stevearc/conform.nvim); linters via [nvim-lint](https://github.com/mfussenegger/nvim-lint).
- Java/Kotlin: [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) (`jdtls`) + `kotlin_lsp`, needs `openjdk@21` (step 8).
- Leader keys: `,` (global), `<space>` (local). Format buffer: `<leader><leader>f`.
- Lua style: 2-space indent, single quotes (see [stylua.toml](.config/nvim/stylua.toml)).

## Tmux

Configuration: [.tmux.conf](.tmux.conf).

- Prefix: **`C-t`** (remapped from default `C-b`)
- Plugin manager: [tpm](https://github.com/tmux-plugins/tpm) at `~/.tmux/plugins/tpm/`
- Reload config: `prefix + R` (or `prefix + r`)

### Claude CLI popup

A floating popup runs the `claude` CLI, driven by [.config/tmux/claude-popup.sh](.config/tmux/claude-popup.sh):

| Key | Action |
| --- | ------ |
| **`Option + a`** | Toggle the popup — opens it, and closes (detaches) when pressed inside it. No prefix needed. |
| `prefix + a` | Open the popup (fallback for the same thing) |

- Each git repo gets its own long-lived `claude-<repo>` tmux session, derived from the pane's path, so conversations/context stay separate per project and survive closing/reopening the popup.
- Launches with `claude --dangerously-skip-permissions`; the status bar is hidden for these sessions.
- `Option + a` relies on WezTerm sending Alt for the **left** Option key (`send_composed_key_when_left_alt_is_pressed = false` in [.wezterm.lua](.wezterm.lua)) — the right Option key still composes special characters.

## Lazygit

Configuration: [.config/lazygit/config.yml](.config/lazygit/config.yml).

Opened via toggleterm in Neovim (`<space>gg`). Pressing `e`/`o` on a file opens it in the **parent** Neovim session (not a nested instance) using Neovim's remote over the `$NVIM` socket. `.zshrc` points lazygit at this tracked config via `LG_CONFIG_FILE`, so `state.yml` stays in lazygit's default dir (out of the repo).

## Git

Configuration: [.gitconfig](.gitconfig).

### Multi-account setup

Identity and signing key swap based on workspace directory via `includeIf "gitdir:..."`:

| Workspace              | Git User           | gh CLI Account  |
| ---------------------- | ------------------ | --------------- |
| `~/Workplace/Karhdo/`  | Karhdo             | Karhdo          |
| `~/Workplace/Spartan/` | Spartan - Khanh Do | spartan-khanhdo |

Commits are GPG-signed using SSH keys (`gpg.format = ssh`), with `~/.ssh/allowed_signers` as the trust list.

### Files

- `~/.gitconfig` — main config with conditional includes
- `~/.gitconfig-karhdo` — personal account (name, email, signingkey) — **not tracked**, create locally (step 9)
- `~/.gitconfig-spartan` — work account (tracked in this repo)

**SSH config (`~/.ssh/config`):**

```ssh
# Karhdo's GitHub
Host github
  HostName github.com
  User git
  IdentityFile ~/.ssh/karhdo
  IdentitiesOnly yes

# Spartan's GitHub
Host github-spartan
  HostName github.com
  User git
  IdentityFile ~/.ssh/spartan
  IdentitiesOnly yes
```

**direnv for gh CLI (`GH_TOKEN`):**

- `~/Workplace/Karhdo/.envrc` — personal GitHub token
- `~/Workplace/Spartan/.envrc` — work GitHub token

### Generate GitHub tokens

1. Go to https://github.com/settings/tokens?type=beta
2. Generate new token with scopes: `repo`, `read:org`, `gist`
3. Create `.envrc` in workspace:

```bash
echo 'export GH_TOKEN=ghp_your_token' > ~/Workplace/YourWorkspace/.envrc
direnv allow ~/Workplace/YourWorkspace
```

## Wezterm

Configuration: [.wezterm.lua](.wezterm.lua). Installed via the Brewfile (`cask "wezterm"`).

## Shell

Configuration: [.zshrc](.zshrc).

- Prompt: [starship](https://starship.rs/) — config at [.config/starship.toml](.config/starship.toml)
- Plugins sourced from `~/.zsh_custom/`: [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) (cloned in step 5)
- Fuzzy finding: [fzf](https://github.com/junegunn/fzf) + [fd](https://github.com/sharkdp/fd) + [bat](https://github.com/sharkdp/bat) preview; theme from [.fzf_tokyonight](.fzf_tokyonight)
- Tool init: [fnm](https://github.com/Schniz/fnm) (Node, auto-switch on `cd`), [zoxide](https://github.com/ajeetdsouza/zoxide), [direnv](https://direnv.net/)
- Font: [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) (Hack)

Common aliases: `v` (nvim), `rz` (reload zsh), `cz` / `cv` (edit `.zshrc` / `init.lua`), `zw` / `zs` / `zd` (jump to workspace dirs).

## Bat

Configuration: [.config/bat/](.config/bat/). Uses the `tokyonight_night` theme (set via `BAT_THEME` in `.zshrc`). Theme sources are third-party clones installed in step 7.

## Reference

- [captainko cko.nvim](https://github.com/captainko/cko.nvim)
- [josean-dev dev-environment-files](https://github.com/josean-dev/dev-environment-files)
