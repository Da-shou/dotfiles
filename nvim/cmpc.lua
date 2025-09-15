local lspkind = require "lspkind"
local cmp = require "cmp"
local snippets = require "mini.snippets"
cmp.setup({
	-- Defining the snippet engine we are using. Right now, this
	snippet = {
		expand = function(args)
			local insert = snippets.config.expand.insert or snippets.default_insert
			insert({ body = args.body }) -- Insert at cursor 
			cmp.resubscribe({ "TextChangedI", "TextChangedP" })
			require("cmp.config").set_onetime({ sources = {} })
		end
	},
	window = {
		completion = cmp.config.window.bordered({
			border = "",
		}),
		documentation = cmp.config.window.bordered({
			border = ""
		})
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			menu = ({
				nvim_lsp = "LSP",
				buffer = "Buffer",
				path = "Path",
			})
		}),
	},
	completion = {
		keyword_pattern = [=[.]=]
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
		{ name = 'buffer' },
		{ name = 'path' }
	},
	experimental = {
		ghost_text = false
	}
})
