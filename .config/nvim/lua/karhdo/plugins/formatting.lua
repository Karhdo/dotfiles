local M = {
	'stevearc/conform.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
}

M.config = function()
	local conform = require('conform')

	-- ktlint is a JVM tool and Mason ships it as a self-executing jar whose shell
	-- wrapper (a) spawns a whole extra JVM just to run `java -version`, (b) hard-codes
	-- `exec java -Xmx512m -jar` so JAVA_OPTS is ignored, and (c) reloads every class
	-- from scratch on each run -- ~3.5s for a small file, which blew past the old
	-- 2s timeout. Invoking java ourselves with an AppCDS archive cuts that to ~1.2s.
	local ktlint_jar = vim.fn.expand('~/.local/share/nvim/mason/packages/ktlint/ktlint')
	local ktlint_cds = vim.fn.stdpath('cache') .. '/ktlint.jsa'

	local function ktlint_cds_fresh()
		local jar = vim.uv.fs_stat(ktlint_jar)
		local cds = vim.uv.fs_stat(ktlint_cds)
		return jar ~= nil and cds ~= nil and cds.mtime.sec >= jar.mtime.sec
	end

	-- Rebuild the archive whenever it is missing or older than the jar (i.e. after
	-- Mason updates ktlint). Priming it needs a real format run, since AppCDS only
	-- archives classes that actually got loaded. Until it lands, `-Xshare:auto`
	-- silently falls back to a normal, slower start -- never an error.
	local function ktlint_build_cds()
		if not vim.uv.fs_stat(ktlint_jar) or ktlint_cds_fresh() then
			return
		end
		vim.system({
			'java',
			'-Xlog:disable',
			'-XX:ArchiveClassesAtExit=' .. ktlint_cds,
			'-Xmx512m',
			'-jar',
			ktlint_jar,
			'--format',
			'--stdin',
			-- Mirror the real invocation (including --stdin-path) so the classes behind
			-- .editorconfig resolution end up in the archive too.
			'--stdin-path=' .. vim.fn.getcwd() .. '/KtlintWarmup.kt',
			'--log-level=none',
		}, { stdin = 'class KtlintWarmup {\n    fun run() = Unit\n}\n' })
	end

	conform.setup({
		formatters_by_ft = {
			javascript = { 'prettierd' },
			typescript = { 'prettierd' },
			javascriptreact = { 'prettierd' },
			typescriptreact = { 'prettierd' },
			css = { 'prettierd' },
			html = { 'prettierd' },
			json = { 'prettierd' },
			yaml = { 'prettierd' },
			markdown = { 'prettierd' },
			graphql = { 'prettierd' },
			liquid = { 'prettierd' },
			lua = { 'stylua' },
			python = { 'black' },
			java = { 'google-java-format' },
			kotlin = { 'ktlint' },
		},

		formatters = {
			ktlint = {
				command = 'java',
				-- ktlint exits 1 when a file still has violations it cannot auto-correct
				-- (e.g. `standard:filename`), yet it still prints the fully formatted
				-- source. Without this, conform would throw that output away and the
				-- buffer would silently stay unformatted. A genuine syntax error exits 0
				-- with empty stdout, which conform already refuses to apply.
				exit_codes = { 0, 1 },
				args = function(_, ctx)
					local args = {
						-- A stale or unusable archive makes the JVM print CDS warnings on
						-- *stdout*, which conform would splice straight into the buffer.
						-- Silence all JVM logging so only ktlint's output can reach the file.
						'-Xlog:disable',
						'-Xshare:auto',
						-- Deliberately NOT setting -XX:TieredStopAtLevel=1: capping the JIT
						-- shaves ~0.5s off small files but triples the cost of large ones
						-- (a 1000-line file goes 8.7s -> 35s). Let the JIT tier up normally.
						'-Xmx512m',
					}

					if ktlint_cds_fresh() then
						table.insert(args, 1, '-XX:SharedArchiveFile=' .. ktlint_cds)
					end

					vim.list_extend(args, {
						'-jar',
						ktlint_jar,
						'--format',
						'--stdin',
						-- Without this ktlint resolves `.editorconfig` from nvim's cwd
						-- rather than the file being formatted, silently ignoring the
						-- project's kotlin style (indent size, disabled rules, ...).
						'--stdin-path=' .. ctx.filename,
						'--log-level=none',
					})

					return args
				end,
			},
			prettierd = {
				env = {
					PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/.config/prettier/prettier.config.js'),
				},
			},
		},
	})

	-- JVM-based formatters (ktlint, google-java-format) pay a ~2-3s JVM startup
	-- cost on every run, so they need a much longer leash than prettierd/stylua.
	local slow_filetypes = {
		kotlin = 15000,
		java = 15000,
	}

	vim.keymap.set({ 'n', 'v' }, '<leader><leader>f', function()
		if vim.bo.filetype == 'kotlin' then
			ktlint_build_cds()
		end

		conform.format({
			lsp_fallback = true,
			async = false,
			timeout_ms = slow_filetypes[vim.bo.filetype] or 2000,
		})
	end, { desc = 'Format file or range (in visual mode)' })
end

return M
