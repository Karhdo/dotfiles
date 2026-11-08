-- Tell LSP servers about renames/moves done in nvim-tree so they fix imports.
return {
	'antosha417/nvim-lsp-file-operations',
	lazy = true, -- Loaded by nvim-lspconfig (for its capabilities) and by nvim-tree
	opts = {},
	config = function(_, opts)
		local lfo = require('lsp-file-operations')
		lfo.setup(opts)

		-- The plugin's own nvim-tree hook is skipped unless nvim-tree loaded first, and it subscribes
		-- again each time the tree reopens (duplicate LSP edits), so subscribe once when nvim-tree loads.
		vim.api.nvim_create_autocmd('User', {
			group = vim.api.nvim_create_augroup('KarhdoLspFileOperations', { clear = true }),
			pattern = 'LazyLoad',
			callback = function(ev)
				if ev.data ~= 'nvim-tree.lua' then
					return
				end
				local api = require('nvim-tree.api')
				local Event = api.events.Event
				for event, handler in pairs({
					[Event.FileCreated] = 'did_create',
					[Event.FolderCreated] = 'did_create',
					[Event.FileRemoved] = 'did_delete',
					[Event.FolderRemoved] = 'did_delete',
					[Event.NodeRenamed] = 'did_rename',
					[Event.WillCreateFile] = 'will_create',
					[Event.WillRemoveFile] = 'will_delete',
					[Event.WillRenameNode] = 'will_rename',
				}) do
					api.events.subscribe(event, lfo[handler])
				end
				return true
			end,
		})
	end,
}
