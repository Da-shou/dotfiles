local darkmode = "catppuccin-mocha"
local lightmode = "catppuccin-latte"

function SwitchMode()
	local current = vim.g.colors_name

	if (current == darkmode) then
		vim.cmd("colorscheme " .. lightmode)
	else
		vim.cmd("colorscheme " .. darkmode)
	end
end
