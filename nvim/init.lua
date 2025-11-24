-- Basic VIM options
vim.o.number = true          -- Show line number
vim.o.relativenumber = false -- Show relative line number
vim.o.cursorline = true      -- Highlight current line number
vim.o.signcolumn = "yes"     -- Show diagnostic column
vim.o.wrap = true            -- Soft-wrap lines at end of window
vim.o.tabstop = 8            -- Tabs are 8 spaces wide
vim.o.swapfile = false       -- Do not use swapfiles
vim.g.mapleader = " "        -- Use space as the leader key
vim.o.winborder = "rounded"  -- Rounded window borders
vim.opt.termguicolors = true -- Use 32-bit colors

--[[ Netrw needs to be disabled for filetree to work
correctly on startup according to wiki ]]
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Put home directory in a variable
local home = vim.fn.expand("~")

-- Hide command line when not using it
vim.cmd("set cmdheight=0")

-- Native plugin adding
vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/onsails/lspkind.nvim" },
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/OXY2DEV/markview.nvim" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-cmdline" },
	{ src = "https://github.com/hiphish/rainbow-delimiters.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/junegunn/fzf" },
	{ src = "https://github.com/junegunn/fzf.vim" },
	{ src = "https://github.com/numToStr/Comment.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
})

-- Mason setup, specfiy which LSP binaries to install.
require "mason".setup()
require "mason-lspconfig".setup()

-- File explorer
require "nvim-tree".setup()

-- Custom terminal config
dofile(home .. "/.config/nvim/terminal.lua")

-- mini.nvim addons. Really useful (and fast) stuff !
require "mini.pairs".setup()    -- Automatic character pairs
require "mini.git".setup()      -- Allows for git status on bar
require "mini.diff".setup()     -- Allows for diff status on bar
require "mini.surround".setup() -- Easily surround selections.

-- Rainbow brackets configuration
dofile(home .. "/.config/nvim/iblc.lua")

-- Notification configuration
require "mini.notify".setup({
	lsp_progress = {
		enable = false,
	},
}) -- Notification window for LSP

-- Autocompletion trigger w/ typing
dofile(home .. "/.config/nvim/cmpc.lua")

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

-- Allows for bulk commenting according to language.
require "Comment".setup({})

-- Add all custom keybinds
dofile(home .. "/.config/nvim/keymaps.lua")

-- Configuring the different LSPs.
-- lua_ls config.
dofile(home .. "/.config/nvim/lspc/lua_ls.lua")
-- jdtl config.	
dofile(home .. "/.config/nvim/lspc/jdtls.lua")
-- Activating emmet-lsp on EJS files
dofile(home .. "/.config/nvim/lspc/emmet-language-server.lua")

vim.lsp.config('bash-language-server', {})
vim.lsp.config('htmlhint', {})
vim.lsp.config('emmet-language-server', {})
vim.lsp.config('cssls', {})

-- Adding the completions capabilities to the LSP
vim.lsp.config("*", { capabilities = require "cmp_nvim_lsp".default_capabilities() })

vim.lsp.enable({
	"clangd",
	"lua_ls",
	"jdtls",
	"bashls",
	"html",
	"htmlhint",
	"eslint",
	"ts_ls",
	"cssls",
})

-- Setting the colorscheme
vim.cmd.colorscheme "catppuccin"

-- Enabling ejs files highlighting
vim.filetype.add({ extension = { ejs = "ejs" } })

-- Adding HTML and JS hightlighting to EJS files
vim.treesitter.language.register("html", "ejs")
vim.treesitter.language.register("javascript", "ejs")
vim.treesitter.language.register("embedded_template", "ejs")

-- Enable treesitter AFTER colorscheme.
require "nvim-treesitter.configs".setup({
	ensure_installed = "all",
	ignore_install = {
		"ipkg"
	},
	highlight = { enable = true },
	preview = { icon_provider = "nvim-web-devicons" }
})
