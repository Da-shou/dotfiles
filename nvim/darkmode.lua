local darkmode = "catppuccin-frappe"
local lightmode = "catppuccin-latte"

function SwitchMode()
	if vim.g.colors_name == darkmode then
		vim.api.nvim_cmd({
			cmd = "colorscheme",
			args = {
				lightmode
			}
		}, {})
	else
		vim.api.nvim_cmd({
			cmd = "colorscheme",
			args = {
				darkmode
			}
		}, {})
	end
end
