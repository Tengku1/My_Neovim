require("core.options") -- Load general options
require("core.keymaps") -- Load general keymaps
--require 'core.snippets' -- Custom code snippets

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require("lazy").setup({
	require("plugins.neotree"),
	require("plugins.colorScheme"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.lsp"),
	require("plugins.neominimap"),
	require("plugins.autocompletion"),
	require("plugins.none-ls"),
	--require("plugins.alpha"),
	require("plugins.debugger"),
	--require 'plugins.gitsigns',
	require("plugins.indent-blankline"),
	require("plugins.misc"),
	require("plugins.comment"),
	require("plugins.dashboard"),
	require("plugins.noice"),
	require("plugins.neoscroll"),
	require("plugins.toggleterm"),
})

vim.cmd([[colorscheme tokyonight-night]])
--vim.cmd("colorscheme material")
vim.cmd([[
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
  set fillchars+=eob:\
]])
