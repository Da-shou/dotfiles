-- Prettier statusline
require "lualine".setup({
	options = {
		icons_enabled = true,
		section_separators = { left = '', right = '' },
		component_separators = { left = '', right = '' },
		globalstatus = false,
	},
	extensions = {
		'toggleterm', 'nvim-tree', 'fzf', 'man', 'mason'
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = {
			'branch',
			{
				'diff',
				diff_color = {
					added    = { gui = 'bold' },
					modified = { gui = 'bold' },
					removed  = { gui = 'bold' },
				},
			},
			{
				'diagnostics',
				symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
				update_in_insert = true,
				always_visible = false
			}
		},
		lualine_c = {
			'filename'
		},
		lualine_x = {
			{
			  function()
			    local clients = vim.lsp.get_clients({ bufnr = 0 })
			    if #clients == 0 then
			      return '󰚦 No LSP'
			    end
			    
			    local names = {}
			    for _, client in ipairs(clients) do
				table.insert(names, client.name)
			    end
			    return ' ' .. table.concat(names, ', ')
			  end,
			  -- Dynamic color logic starts here
			  color = function()
			    local clients = vim.lsp.get_clients({ bufnr = 0 })
			    if #clients > 0 then
			      return { fg = '#A6E3A1', gui = 'bold' } -- Green for active
			    else
			      return { fg = '#F38BA8', gui = 'bold' } -- Red for inactive
			    end
			  end,
			},
			{ 'filetype', icon_only = false, color = { gui = 'bold' } },
			'encoding',
			'fileformat',
			'filesize',
		},
		lualine_y = {
			{ 'datetime', color = { gui = 'bold' }, style = '%d.%m.%y %H:%M' },
		},
		lualine_z = {
			{ 'location', padding = 0 },
			'progress',
		}
	},
})
