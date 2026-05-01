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

-- Configuring the diagnostic icons and colors
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
			[vim.diagnostic.severity.INFO] = '',
			[vim.diagnostic.severity.HINT] = ''
		}
	}
})

-- Put home directory in a variable
local config_path = vim.fn.stdpath("config")

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
	{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/junegunn/fzf" },
	{ src = "https://github.com/junegunn/fzf.vim" },
	{ src = "https://github.com/numToStr/Comment.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/kwkarlwang/bufresize.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/Saghen/blink.lib" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
})

-- Windows stuff for fzf to work correctly...
if vim.fn.has("win32") == 1 then
	vim.g.fzf_binary_path = 'C:/Program Files/fzf/fzf.exe'
	vim.opt.shell = "cmd.exe"
	vim.opt.shellcmdflag = "/c"
end

-- Mason setup, specfiy which LSP binaries to install.
require "mason".setup()
require "mason-lspconfig".setup()

require "toggleterm".setup()

require "tree-sitter-manager".setup({
	border = "rounded",
	auto_install = true,
	highlight = true,
})

require "render-markdown".setup()

require "blink.cmp".setup({
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},
	completion = {
		trigger = {
			show_on_backspace = false,
			show_on_backspace_in_keyword = true,
		},
		ghost_text = {
			enabled = true,
		},
		menu = {
			min_width = 15,
			max_height = 20,
			draw = {
				align_to = 'label',
				padding = 3,
				columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 3 }},
			}
		},
		documentation = {
			-- Show documentation with <C-Space>
			auto_show = false,
		}
	},
	keymap = {
		preset = 'default',
	},
	signature = {
		enabled = true
	},
	fuzzy = { implementation = "prefer_rust" }
})

-- Very useful plugin allowing to keep ratio of splits
-- when resizing windows.
require "bufresize".setup()

-- mini.nvim addons. Really useful (and fast) stuff !
require "mini.pairs".setup()      -- Automatic character pairs.
require "mini.git".setup()        -- Allows for git status on bar.
require "mini.diff".setup()       -- Allows for diff status on bar.
require "mini.surround".setup()   -- Easily surround selections.
require "mini.cursorword".setup() -- Highlights current word.
require "mini.starter".setup()    -- Adds nice starterscreen.
require "mini.move".setup()       -- Allows moving hunks of text.
require "mini.colors".setup()     -- Allows for customisable themes
require "mini.animate".setup({
	cursor = { enable = false },
	scroll = { enable = false },
	resize = { enable = false },
	open = { enable = false },
	close = { enable = false },
}) -- Added for smooth animation when switching from light to dark theme

require "mini.indentscope".setup({
	symbol = '│',
	draw = {
		animation = require "mini.indentscope".gen_animation.none(),
		delay = 0
	}
}) -- Shows the indent scope with a line

require "mini.notify".setup({
	lsp_progress = {
		enable = false,
	},
}) -- Notification configuration


-- Settings the icons of some filetypes
dofile(config_path .. "/icons.lua")

-- Lua line status configuration
dofile(config_path .. "/lualine.lua")

-- Add dark mode switcher
dofile(config_path .. "/darkmode.lua")

-- Add all custom keybinds
dofile(config_path .. "/keymaps.lua")

-- Configuring the different LSPs.
-- lua_ls config.
dofile(config_path .. "/lspc/lua_ls.lua")
dofile(config_path .. "/lspc/jdtls.lua")

vim.lsp.config('neocmake', {
	cmd = { "neocmakelsp", "stdio" },
})

-- Setting the colorscheme
vim.cmd.colorscheme "catppuccin-frappe"

vim.cmd [[ autocmd RecordingEnter * set cmdheight=1 ]]
vim.cmd [[ autocmd RecordingLeave * set cmdheight=0 ]]
