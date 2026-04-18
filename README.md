# Karhdo's dotfiles

![nvim screenshot](./images/screenshot-neovim.png)

## Contents

- [Installation](#installation)
- [Neovim](#neovim)
- [Tmux](#tmux)
- [Git](#git)
- [Wezterm](#wezterm)
- [Shell](#shell)
- [Bat](#bat)

## Installation

Files are laid out so the repo root mirrors `$HOME`. Symlinks are managed with [GNU Stow](https://www.gnu.org/software/stow/):

```bash
git clone https://github.com/Karhdo/dotfiles ~/Workplace/Karhdo/dotfiles
cd ~/Workplace/Karhdo/dotfiles
stow -t ~ .
```

`.stow-local-ignore` excludes `README.md`, `.git`, and other repo-only files from being symlinked.

### Prerequisites

```bash
brew install stow neovim tmux starship bat fd fzf eza fnm zoxide direnv gnupg
```

## Neovim

Requires [Neovim](https://neovim.io/) **>= 0.11** (tested on 0.12.1).

- Entry point: [.config/nvim/init.lua](.config/nvim/init.lua) → loads `karhdo.core`, `karhdo.lazy`, `karhdo.lsp`.
- Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim) — specs auto-imported from [.config/nvim/lua/karhdo/plugins/](.config/nvim/lua/karhdo/plugins/).
- LSP tooling via [mason.nvim](https://github.com/williamboman/mason.nvim); formatters via [conform.nvim](https://github.com/stevearc/conform.nvim); linters via [nvim-lint](https://github.com/mfussenegger/nvim-lint).
- Leader keys: `,` (global), `<space>` (local). Format buffer: `<leader><leader>f`.
- Lua style: 2-space indent, single quotes (see [stylua.toml](.config/nvim/stylua.toml)).

Plugin versions are pinned in [.config/nvim/lazy-lock.json](.config/nvim/lazy-lock.json); run `:Lazy sync` to update.

## Tmux

Configuration: [.tmux.conf](.tmux.conf).

- Prefix: **`C-t`** (remapped from default `C-b`)
- Plugin manager: [tpm](https://github.com/tmux-plugins/tpm) at `~/.tmux/plugins/tpm/`
- Reload config: `prefix + R`

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
- `~/.gitconfig-karhdo` — personal account (name, email, signingkey) — **not tracked**, create locally
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

Configuration: [.wezterm.lua](.wezterm.lua).

## Shell

Configuration: [.zshrc](.zshrc).

- Prompt: [starship](https://starship.rs/) — config at [.config/starship.toml](.config/starship.toml)
- Plugins sourced from `~/.zsh_custom/`: [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) (not vendored)
- Fuzzy finding: [fzf](https://github.com/junegunn/fzf) + [fd](https://github.com/sharkdp/fd) + [bat](https://github.com/sharkdp/bat) preview; theme from [.fzf_tokyonight](.fzf_tokyonight)
- Tool init: [fnm](https://github.com/Schniz/fnm) (Node, auto-switch on `cd`), [zoxide](https://github.com/ajeetdsouza/zoxide), [direnv](https://direnv.net/)
- Font: [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) (Hack)

Common aliases: `rz` (reload zsh), `cz` / `cv` (edit `.zshrc` / `init.lua`), `zw` / `zs` / `zd` (jump to workspace dirs).

## Bat

Configuration: [.config/bat/](.config/bat/). Uses the `tokyonight_night` theme (set via `BAT_THEME` in `.zshrc`).

Theme sources are third-party clones and **not tracked** in this repo. Install them on a fresh machine:

```bash
git clone https://github.com/0xTadash1/bat-into-tokyonight ~/.config/bat/bat-into-tokyonight
git clone https://github.com/folke/tokyonight.nvim ~/.config/bat/themes/tokyonight.nvim
bat cache --build
```

## Reference

- [captainko cko.nvim](https://github.com/captainko/cko.nvim)
- [josean-dev dev-environment-files](https://github.com/josean-dev/dev-environment-files)
