-- Pretty devicons for statusline and nvim-tree
require "nvim-web-devicons".setup({
	override_by_filename = {
		["CMakeLists.txt"] = {
			color = "#5590de",
			icon = "",
			name = "CMakeLists.txt"
		},
		["Makefile"] = {
			color = "#ca8888",
			icon = "",
			name = "Makefile"
		},
		[".gitignore"] = {
			color = "#f05133",
			icon = "󱞃",
			name = ".gitignore"
		},
	};
	override_by_extension = {
		["exe"] = {
			icon = "󰖳",
			color = "#11bbff",
			name = "windows-executable"
		},
		["glsl"] = {
			icon = "󰠱",
			color = "#eedd88",
			name = "gl-shader-file"
		},
		["png"] = {
			icon = "",
			color = "#00aaaa",
			name = "png-image"
		},
		["c"] = {
			icon = "",
			color = "#5577bb",
			name = "c-source"
		},
		["h"] = {
			icon = "",
			color = "#995599",
			name = "c-header"
		},
	};
})

-- File explorer
require "nvim-tree".setup({
	renderer = {
		icons = {
			glyphs = {
				git = {
					ignored = ""
				}
			}
		}
	},
	git = {
		ignore = false
	}
})
