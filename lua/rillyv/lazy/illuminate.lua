return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({
			delay = 0,
			under_cursor = true,
			filetypes_denylist = {
				"oil",
				"fugitive",
				"TelescopePrompt",
			},
		})

		-- Highlight style for illuminated words
		vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#393552" })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#393552" })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#393552" })
	end,
}
