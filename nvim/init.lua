-- Basic VIM options
vim.o.relativenumber = false
vim.o.signcolumn = "yes"
vim.o.wrap = true
vim.o.tabstop = 8
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"

vim.cmd("set cmdheight=0")

-- Keybinding for sourcing
vim.keymap.set('n', '<leader>o', ':update | :source %<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- Native plugin adding
vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim" },
	{ src = "https://github.com/xiyaowong/transparent.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/OXY2DEV/markview.nvim" },
})

-- Mason setup, specfiy which LSP binaries to install.
require "mason".setup()
require "mason-lspconfig".setup()

-- mini.nvim addons. Really useful (and fast) stuff !
require "mini.pick".setup()       -- File searcher
require "mini.starter".setup()    -- Pretty start screen
require "mini.notify".setup()     -- Notification window for LSP
require "mini.icons".setup()      -- File icons
require "mini.files".setup()      -- File explorer
require "mini.pairs".setup()      -- Automatic character pairs
require "mini.tabline".setup()    -- Allow multiple tabs
require "mini.completion".setup() -- Autocompletion trigger w/ typing
require "mini.snippets".setup()   -- Useful code snippets.
require "mini.git".setup()        -- Allows for git status on bar
require "mini.diff".setup()       -- Allows for diff status on bar

-- Pretty devicons for statusline
require "nvim-web-devicons".setup()

-- Prettier statusline
require "lualine".setup({
	options = {
		icons_enabled = true,
		theme = "catppuccin",
		section_separators = { left = '', right = '' },
		component_separators = { left = '', right = '' }
	}
})

-- Useful keymaps for choosing and searching files.
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>e', ":lua MiniFiles.open()<CR>")

-- Next tab, previous tab, delete tab.
vim.keymap.set('n', '<Tab>', ":bnext<CR>")
vim.keymap.set('n', '<S-Tab>', ":bprevious<CR>")
vim.keymap.set('n', '<leader>q', ":write | :bdelete<CR>")
vim.keymap.set('n', '<leader>md', ":Markview<CR>")

-- Enabling LSP
vim.lsp.enable({ "lua_ls", "pyright", "clangd" })

-- Setting the colorscheme
vim.cmd.colorscheme "catppuccin"

-- Enable treesitter AFTER colorscheme.
require "nvim-treesitter.configs".setup({
	highlight = {enable = true},
	preview = {
		icon_provider = "devicons"
	}
})
