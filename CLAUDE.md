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

`~/.ssh/config` (outside the repo) routes `github` vs `github-spartan` hosts to different keys; remotes always use those SSH aliases, never HTTPS.

Per-workspace `.envrc` files (loaded by `direnv`) give the `gh` CLI a distinct `GH_TOKEN` per account. They are tracked here under `Workplace/Karhdo/.envrc` and `Workplace/Spartan/.envrc` and hold no secrets: each reads its token from the macOS Keychain with `gh auth token --user <account>`, so both accounts must be logged in with `gh auth login`. Stow links the Spartan one; it skips `Workplace/Karhdo` because the stow directory lives there, so that link is made by hand: `ln -s dotfiles/Workplace/Karhdo/.envrc ~/Workplace/Karhdo/.envrc`. Run `direnv allow` in each workspace after changing either file.

### Neovim config (`.config/nvim/`)

Entry point: `init.lua` sets the leaders, then loads `karhdo.core` (options, keymaps, autocommands, LSP attach/diagnostics in `core/lsp.lua`) and `karhdo.lazy`.

- Plugin manager: **lazy.nvim** (bootstrapped in `lua/karhdo/lazy.lua`). Specs are auto-imported from `lua/karhdo/plugins/` and `lua/karhdo/plugins/lsp/`.
- LSP tooling is installed via **mason** + **mason-lspconfig** + **mason-tool-installer** (`plugins/lsp/mason.lua` holds the `ensure_installed` lists); per-server config is in `plugins/lsp/lspconfig.lua`. pyright uses the nearest `.venv` above the project root (one per service in monorepos), with ruff alongside it for lint, import sorting and formatting (pyright's "not accessed" hints are off, since ruff reports the same); tailwindcss only starts under a Tailwind/PostCSS config or a package.json that depends on Tailwind; postgres_lsp falls back to the git root when there is no `postgres-language-server.jsonc`. Formatters run via **conform.nvim** (`plugins/formatting.lua`); linters via **nvim-lint** (`plugins/linting.lua`, auto-triggers on `BufEnter`/`BufWritePost`/`InsertLeave`).
- Leader keys: `,` (global), `<space>` (local). Format: `<leader><leader>f`.
- **nvim-treesitter tracks the `main` branch** (`master` is frozen and does not support nvim 0.12). `main` has no module system, so `plugins/treesitter.lua` wires up highlighting, indentation and incremental selection by hand in a `FileType` autocmd. It also builds parsers locally, so **`tree-sitter-cli` (≥ 0.26.1, via brew — not npm) is a prerequisite**; parsers land in `~/.local/share/nvim/site/parser`, not in the plugin directory. Indentation is only enabled for languages that ship an `indents.scm` — kotlin doesn't, and keeps the runtime's `GetKotlinIndent()`.

#### Neovim conventions

Follow these for every change under `.config/nvim/`; existing files are the reference.

**Plugin specs**
- One plugin per file, named after the plugin (`nvim-tree.lua`) or its role (`formatting.lua` for conform). LSP-related plugins go in `plugins/lsp/`.
- Start the file with a one-line `--` comment saying what the plugin is for, then `return { ... }`. Helpers and constants the spec needs go above the `return` as locals; never `local M = {}` / `function M.config()`.
- Spec fields in this order: repo, `enabled`/`cond`, `branch`/`version`/`build`, `lazy`/`priority`, `event`/`cmd`/`ft`/`keys`, `dependencies`, `main`, `init`, `opts`, `config`.
- Configure with `opts` whenever the plugin only needs `setup(opts)`; lazy.nvim calls it for you. Use `opts = function() ... end` when building the table needs a `require`. Add `config = function(_, opts)` only for work beyond `setup` (extra wiring, autocmds, a non-`setup` entry point), and pass `opts` through.
- Every plugin declares when it loads: `event`, `cmd`, `ft` or `keys`. Plugins that only exist as a dependency get `lazy = true`. `lazy = false` needs a comment saying why (colorscheme, nvim-treesitter `main`). Prefer `VeryLazy` for UI that is not needed for the first frame.
- Don't restate defaults (`enabled = true`, `lazy = false` on a plugin that has a trigger, empty `setup({})` in `config`).
- Shared glyphs, colors and borders come from `core/styles.lua`, never copied into a spec. Icons must be Nerd Font **v3** codepoints (the v2-only range U+F500–U+FD46 renders blank).
- After adding, removing or updating plugins, commit `lazy-lock.json` together with the spec change.

**Keymaps**
- Global keymaps that belong to a plugin go in its spec's `keys` (this is also what lazy-loads it): `{ lhs, rhs, mode = ..., desc = '...' }`. Editor keymaps with no plugin go in `core/keymaps.lua`.
- Buffer-local keymaps (LSP, gitsigns) are set in the attach callback through a local `map(mode, lhs, rhs, desc)` helper that adds `buffer = ...`.
- Every keymap has a `desc`: sentence case, starts with a verb, no trailing period, no plugin name unless it disambiguates (`'Find files in cwd'`, `'Next hunk'`).
- Right-hand sides: a Lua function, or `<Cmd>...<CR>` for an Ex command. Use `:` only when a range is needed (visual-mode `:m '>+1`), and say so in a comment.
- Key notation: `<leader>`, `<localleader>`, `<C-x>`, `<A-x>`, `<S-x>`, `<CR>`, `<Cmd>`, `<BS>`, `<Space>`. Visual-mode maps use `x`, not `v` (`v` also hits select mode, i.e. snippet placeholders).
- Before taking a key, check it is free (`:verbose map <key>`) and that it is not a prefix of an existing map. Give every new `<leader>` prefix a `group` label in `plugins/which-key.lua`.
- Current prefixes: `<leader>b` buffers, `<leader>c` code / conflicts, `<leader>g` git review (codediff), `<leader>h` git hunks (gitsigns), `<leader>s` splits, `;` fzf-lua pickers. Git hunk keys are deliberately the same in gitsigns and codediff.

**Autocommands**
- Always in an augroup named `Karhdo<Name>` with `clear = true`; use `callback` functions, not `command` strings.

**Lua style**
- `stylua.toml` is the source of truth: tabs (width 2), single quotes, call parentheses always, 120 columns. Run `~/.local/share/nvim/mason/bin/stylua .config/nvim` before committing.
- Comments explain *why* (a workaround, a non-obvious constraint), not what the next line does. Use `vim.uv`, `vim.keymap.set`, `vim.api.nvim_create_autocmd`, `vim.lsp.config`/`vim.lsp.enable`; no deprecated APIs (`:checkhealth vim.deprecated` must stay clean).
- `.luarc.json` declares the `vim` global for editors outside Neovim; inside Neovim, lazydev provides the types.

**Verifying a change**
- Start nvim on a real file and check `:messages`, `:checkhealth lazy vim.deprecated`, and `:Lazy` (load times, nothing unexpectedly loaded at startup). Press any keymap you added.

### Shell (`.zshrc`)

- Prompt: **starship** (`.config/starship.toml`).
- Plugins sourced from `~/.zsh_custom/` (zsh-autosuggestions, zsh-syntax-highlighting) — these are not vendored in this repo.
- FZF integrates with **fd** for file/dir discovery and **bat** for preview; theme options are read from `~/.fzf_tokyonight`.
- `v` alias points to a standalone Neovim binary at `~/Workplace/Karhdo/nvim-macos-arm64/bin/nvim` (not the system `nvim`).
- Tool initializers chained via `eval`: `fnm` (Node), `zoxide`, `direnv`. Node version switches on `cd` via `--use-on-cd`.
- Docker has no Docker Desktop: the engine runs in **Colima**'s VM (`colima start`/`stop`) and the Homebrew `docker` CLI talks to it. `DOCKER_HOST` points at `~/.colima/default/docker.sock` because Testcontainers ignores Docker contexts; `TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock` is the socket's path *inside* the VM. Colima only shares `$HOME` with the VM, so bind mounts from `/tmp` come up empty.

### Tmux (`.tmux.conf`)

Prefix is remapped to **`C-t`** (not default `C-b`). Plugin manager is **tpm** at `~/.tmux/plugins/tpm/`; reload config with `prefix + R`.

Claude Code runs in popups via the **tmux-claude-hatch** plugin, launched with `--dangerously-skip-permissions` (`@claude_args`). `.config/tmux/claude-popup.sh` (bound to `y`/`Y`, overriding the plugin's `y`, so those bindings must stay after the tpm `run` line) keeps one popup session per outer tmux session, keyed by its start dir (`#{session_path}`, e.g. the `LoanBud` session → `loanbud-hq`). Inside it each directory gets its own window (tagged `@claude_dir`) running Claude in the pane's current dir. `@claude_command` points at `.config/tmux/claude.sh`, which drops to a shell when Claude exits so the popup's session survives (`exit` closes it); piped calls such as the picker's `claude agents --json` fallback pass straight through.

The picker (`u`) is the plugin's, but its `enter` is rebound through `@claude_fzf_options` to `.config/tmux/claude-pick.sh`. That clears `@claude_parent` (the terminal the plugin would switch; `list.sh` sets it again on the next `u`) and hands the row back, so the plugin opens the chosen Claude in the popup over the current window instead of switching to the session that launched it. Claudes in ordinary panes keep the plugin's jump to the pane. Don't attach from inside fzf's `become` instead: tmux rejects `/dev/tty` as a terminal and the popup comes up blank.

| Key | Action |
|---|---|
| `prefix + y` | Open/reattach Claude for the current dir in the tmux session's popup |
| `prefix + Y` | Same, but a newly started Claude gets `--resume` (no effect if that dir's window already exists) |
| `prefix + u` | fzf picker of all running Claudes with status; picking one opens it in the popup over the current window, without switching session |
| `prefix + d` | Hide the popup; Claude keeps running |
| `prefix + N` | Renumber windows (`renumber-windows on` already does this on close) |

The status bar theme **tmux-tokyo-night is pinned to `v1.11.0`** (`#v1.11.0` in `.tmux.conf`; v5+ is a rewrite with a different look and extra key bindings). tpm only honours that pin on a fresh install — its updater just runs `git pull` — so the local checkout also has its `origin` remote removed, which makes `prefix + U` fail for that plugin instead of upgrading it. Don't re-add the remote or run tpm updates on it.

`source-file` only adds or overrides bindings; after removing or renaming a `bind-key`, also `tmux unbind-key -T prefix <key>` in the running server.

## Common tasks

Reload shell config: `rz` (alias for `source ~/.zshrc`).
Edit this repo's `.zshrc`: `cz`. Edit nvim entry: `cv`.
Reload tmux: inside tmux, `C-t R`.
Nvim plugin lock: `.config/nvim/lazy-lock.json` — commit changes to this file when plugin versions are intentionally bumped via `:Lazy sync`/`:Lazy update`.

## Gotchas

- When editing `.gitconfig`, remember the personal overrides live in an **untracked** `~/.gitconfig-karhdo`; don't assume a fresh clone will have the same identity behavior until that file is created and `direnv allow` has been run in each workspace.
- `.stow-local-ignore` must stay in sync with any new top-level files/directories you don't want symlinked into `$HOME`.
- The repo mixes two layouts: some configs sit at the repo root (`.zshrc`, `.tmux.conf`) while others live under `.config/` (XDG-style). Don't relocate files without checking how they'd resolve after `stow`.
