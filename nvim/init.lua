-- Basic VIM options
vim.o.number = true
vim.o.relativenumber = false
vim.o.signcolumn = "yes"
vim.o.wrap = false
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
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-cmdline" },
	{ src = "https://github.com/abeldekat/cmp-mini-snippets" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
})

-- Mason setup, specfiy which LSP binaries to install.
require "mason".setup()
require "mason-lspconfig".setup()

-- mini.nvim addons. Really useful (and fast) stuff !
require "mini.pick".setup()     -- File searcher
require "mini.starter".setup()  -- Pretty start screen
require "mini.icons".setup()    -- File icons
require "mini.files".setup()    -- File explorer
require "mini.pairs".setup()    -- Automatic character pairs
require "mini.tabline".setup()  -- Allow multiple tabs
require "mini.git".setup()      -- Allows for git status on bar
require "mini.diff".setup()     -- Allows for diff status on bar
require "mini.surround".setup() -- Easily surround selections.

-- Notification configuration
require "mini.notify".setup({
	lsp_progress = {
		enable = false,
	},
})   -- Notification window for LSP

local snippets = require "mini.snippets"
snippets.setup({
	snippets = {
		snippets.gen_loader.from_lang()
	}
})
snippets.start_lsp_server()

-- Autocompletion trigger w/ typing	
local cmp = require 'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
			local insert = snippets.config.expand.insert or snippets.default_insert
			insert({ body = args.body }) -- Insert at cursor 
			cmp.resubscribe({ "TextChangedI", "TextChangedP" })
			require("cmp.config").set_onetime({ sources = {} })
		end
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'mini.snippets' },
		{ name = 'buffer' },
		{ name = 'path' }
	}
})

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

-- Run :make command with keybind
vim.keymap.set('n', '<leader>m', ":make<CR>")

-- Configuring the different LSPs.
-- Lua LSP
local lspconfig = require("lspconfig")
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			completion = {
				callSnippet = "Replace",
			}
		},
	}
})

-- Java LSP
vim.lsp.config("jdtls", {
	settings = {
		java = {
			home = "usr/bin/java"
		}
	}
})

-- Adding the completions capabilities to the LSP
vim.lsp.config("*", {capabilities = require "cmp_nvim_lsp".default_capabilities()})

vim.lsp.enable({
	"clangd",
	"lua_ls",
	"jdtls",
	"biome"
})

-- Setting the colorscheme
vim.cmd.colorscheme "catppuccin"

-- Enable treesitter AFTER colorscheme.
require "nvim-treesitter.configs".setup({
	ensure_installed = "all",
	ignore_install = {
		"ipkg"
	},
	highlight = { enable = true },
	preview = { icon_provider = "mini" }
})
