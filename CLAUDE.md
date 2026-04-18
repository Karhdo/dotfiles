# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Personal dotfiles for macOS. Files are laid out so the repo root mirrors `$HOME`: `.zshrc`, `.tmux.conf`, `.wezterm.lua`, `.gitconfig`, and `.config/` at the top level are intended to be symlinked into the user's home directory.

`.stow-local-ignore` is present, indicating GNU Stow is the expected symlink tool (run from the repo root, targeting `$HOME`). The file excludes `README.md`, `.git`, and common noise from stowing.

## Architecture

### Git multi-account routing

`.gitconfig` uses `includeIf "gitdir:..."` to swap identity/signing key based on the workspace directory:

- `~/Workplace/Karhdo/` → `~/.gitconfig-karhdo` (personal)
- `~/Workplace/Spartan/` → `~/.gitconfig-spartan` (work, this repo tracks the spartan variant)

Commits are GPG-signed via SSH key (`gpg.format = ssh`, `commit.gpgsign = true`), with `~/.ssh/allowed_signers` as the trust list. The personal `.gitconfig-karhdo` is intentionally NOT tracked in this repo — only the Spartan one is.

Companion pieces live outside the repo: `~/.ssh/config` routes `github` vs `github-spartan` hosts to different keys, and per-workspace `.envrc` files (loaded by `direnv`) provide distinct `GH_TOKEN` values for the `gh` CLI.

### Neovim config (`.config/nvim/`)

Entry point: `init.lua` → loads `karhdo.core`, `karhdo.lazy`, `karhdo.lsp`.

- Plugin manager: **lazy.nvim** (bootstrapped in `lua/karhdo/lazy.lua`).
- Plugin specs: auto-imported from `lua/karhdo/plugins/` and `lua/karhdo/plugins/lsp/` — each file returns a lazy.nvim spec table, so adding a plugin means dropping a new file into that directory.
- LSP tooling is installed via **mason** + **mason-lspconfig** + **mason-tool-installer** (see `plugins/lsp/mason.lua` for the `ensure_installed` lists). Formatters run via **conform.nvim** (`plugins/formatting.lua`); linters via **nvim-lint** (`plugins/linting.lua`, auto-triggers on `BufEnter`/`BufWritePost`/`InsertLeave`).
- Leader keys: `,` (global), `<space>` (local). Format: `<leader><leader>f`. LSP keymaps are set in `lsp.lua` inside an `LspAttach` autocmd.
- Lua style enforced by `stylua.toml`: 2-space indent, single quotes, always use call parentheses.

### Shell (`.zshrc`)

- Prompt: **starship** (`.config/starship.toml`).
- Plugins sourced from `~/.zsh_custom/` (zsh-autosuggestions, zsh-syntax-highlighting) — these are not vendored in this repo.
- FZF integrates with **fd** for file/dir discovery and **bat** for preview; theme options are read from `~/.fzf_tokyonight`.
- `v` alias points to a standalone Neovim binary at `~/Workplace/Karhdo/nvim-macos-arm64/bin/nvim` (not the system `nvim`).
- Tool initializers chained via `eval`: `fnm` (Node), `zoxide`, `direnv`. Node version switches on `cd` via `--use-on-cd`.

### Tmux (`.tmux.conf`)

Prefix is remapped to **`C-t`** (not default `C-b`). Plugin manager is **tpm** at `~/.tmux/plugins/tpm/`; reload config with `prefix + R`.

## Common tasks

Reload shell config: `rz` (alias for `source ~/.zshrc`).
Edit this repo's `.zshrc`: `cz`. Edit nvim entry: `cv`.
Reload tmux: inside tmux, `C-t R`.
Nvim plugin lock: `.config/nvim/lazy-lock.json` — commit changes to this file when plugin versions are intentionally bumped via `:Lazy sync`/`:Lazy update`.

## Gotchas

- When editing `.gitconfig`, remember the personal overrides live in an **untracked** `~/.gitconfig-karhdo`; don't assume a fresh clone will have the same identity behavior until that file is created and `direnv allow` has been run in each workspace.
- `.stow-local-ignore` must stay in sync with any new top-level files/directories you don't want symlinked into `$HOME`.
- The repo mixes two layouts: some configs sit at the repo root (`.zshrc`, `.tmux.conf`) while others live under `.config/` (XDG-style). Don't relocate files without checking how they'd resolve after `stow`.
