-- Git signs in the gutter, inline blame and hunk actions.
return {
	'lewis6991/gitsigns.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	opts = {
		current_line_blame = true,
		current_line_blame_formatter = '  <author>, <author_time:%R> • <summary>',
		current_line_blame_opts = {
			delay = 100,
			virt_text_pos = 'eol',
			-- eol virtual text is drawn in ascending priority, so going above the
			-- diagnostics' default (4096) puts the blame after the error message.
			virt_text_priority = 5000,
		},
		on_attach = function(bufnr)
			local gs = require('gitsigns')

			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			local function selected_lines()
				return { vim.fn.line('.'), vim.fn.line('v') }
			end

			map('n', ']h', function()
				gs.nav_hunk('next')
			end, 'Next hunk')
			map('n', '[h', function()
				gs.nav_hunk('prev')
			end, 'Previous hunk')

			map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
			map('x', '<leader>hs', function()
				gs.stage_hunk(selected_lines())
			end, 'Stage selected lines')
			-- stage_hunk on an already-staged hunk unstages it (undo_stage_hunk is
			-- deprecated), so this mirrors codediff's <leader>hu.
			map('n', '<leader>hu', gs.stage_hunk, 'Unstage hunk')
			map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
			map('x', '<leader>hr', function()
				gs.reset_hunk(selected_lines())
			end, 'Reset selected lines')
			map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
			map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')
			map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')

			map('n', '<leader>hb', function()
				gs.blame_line({ full = true })
			end, 'Blame line')
			map('n', '<leader>hB', gs.toggle_current_line_blame, 'Toggle line blame')

			-- File diffs open in codediff for VSCode-style side-by-side views.
			map('n', '<leader>hd', '<Cmd>CodeDiff file HEAD<CR>', 'Diff file against HEAD')
			map('n', '<leader>hD', '<Cmd>CodeDiff file HEAD~1<CR>', 'Diff file against HEAD~1')

			map({ 'o', 'x' }, 'ih', gs.select_hunk, 'Select hunk')
		end,
	},
}
