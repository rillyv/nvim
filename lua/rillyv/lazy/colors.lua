function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "LspInlayHint", { bg = "none", fg = "#6e6a86", italic = true })

	-- Try different keyword highlight groups
	vim.api.nvim_set_hl(0, "@keyword", { fg = "#eb6f92" })
	vim.api.nvim_set_hl(0, "@keyword.repeat", { fg = "#eb6f92" })
	vim.api.nvim_set_hl(0, "@keyword.operator", { fg = "#eb6f92" })
	vim.api.nvim_set_hl(0, "Keyword", { fg = "#eb6f92" })

	-- Make all variables the same color (like PHPStorm)
	local var_color = "#c4a7e7" -- rose-pine iris
	vim.api.nvim_set_hl(0, "@variable", { fg = var_color })
	vim.api.nvim_set_hl(0, "@variable.parameter", { fg = var_color })
	vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = var_color })
	vim.api.nvim_set_hl(0, "@lsp.type.variable", { fg = var_color })

	-- Named argument labels (less prominent)
	vim.api.nvim_set_hl(0, "@label", { fg = "#6e6a86" }) -- rose-pine muted
	vim.api.nvim_set_hl(0, "@label.php", { fg = "#6e6a86" })

	-- Illuminate (highlight word under cursor)
	vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#393552" })
	vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#393552" })
	vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#393552" })

	vim.api.nvim_set_hl(0, "Search", { bg = "#f6c177", fg = "#191724", bold = true })
	vim.api.nvim_set_hl(0, "IncSearch", { bg = "#eb6f92", fg = "#191724", bold = true })
	vim.api.nvim_set_hl(0, "CurSearch", { bg = "#eb6f92", fg = "#191724", bold = true })

	-- Trigger ColorScheme event so lualine picks up the theme
	vim.cmd("doautocmd ColorScheme")
end

return {
	{
		"erikbackman/brightburn.vim",
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		opts = {},
		config = function()
			ColorMyPencils()
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = false,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
				},
			})

			ColorMyPencils()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "rose-pine" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "rose-pine",
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					icons_enabled = true,
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						{
							"branch",
							fmt = function(str)
								return str:match("[^/]+$"):sub(1, 20)
							end,
						},
						"diff",
					},

					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
