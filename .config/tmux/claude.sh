#!/usr/bin/env bash
# tmux-claude-hatch's @claude_command: run Claude, then keep the popup's tmux
# session alive with a shell when Claude exits (e.g. ctrl+c), instead of letting
# the session die with it. Run `claude` again from that shell, or `exit` to close.
#
# Non-interactive calls (the picker's `claude agents --json` fallback, whose
# output is piped) pass straight through so they never hang on a shell.

[ -t 1 ] || exec claude "$@"

claude "$@"
exec "${SHELL:-/bin/zsh}"
