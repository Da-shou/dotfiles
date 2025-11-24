local lspkind = require "lspkind"
local cmp = require "cmp"

-- Make the cmp windows borders' background entirely transparent
-- Only call this function when the colorscheme nvim function is used.
vim.api.nvim_create_autocmd("colorscheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#333344", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = "#333344", bg = "NONE" })
	end,
})

cmp.setup({
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end
	},
	window = {
		completion = cmp.config.window.bordered({
			border = "rounded", -- "single", "double", "shadow", etc.
			-- Setting the nvimcmd highlight groups to be sure that our custom works.
			winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
		}),
		documentation = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder,CursorLine:PmenuSel,Search:None",
		}),
	},
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = lspkind.cmp_format({
			mode = "symbol_text",
			menu = ({
				nvim_lsp = "LSP",
				buffer = "Buffer",
				path = "Path",
			}),
		}),
	},
	matching = {
		disallow_fuzzy_matching = false
	},
	completion = {
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<C-j>'] = cmp.mapping.select_next_item(),
		['<C-k>'] = cmp.mapping.select_prev_item(),
	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'nvim_lsp_signature_help' }
	},
	experimental = {
		ghost_text = false
	}
})
