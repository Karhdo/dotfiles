--- Store all callbacks in one global table so they are able to survive re-requiring this file
_G.__karhdo_global_callbacks = __karhdo_global_callbacks or {}

_G.karhdo = { _store = __karhdo_global_callbacks }

---Projected require
-- @param package string
karhdo.p_require = function(package)
	return pcall(require, package)
end

karhdo.config = function(package)
	local has_config, config = karhdo.p_require("karhdo.plugins." .. package)
	if has_config then
		return config
	end
	return nil
end

karhdo.map = function(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end
