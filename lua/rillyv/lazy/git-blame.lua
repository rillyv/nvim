return {
	"FabijanZulj/blame.nvim",
	lazy = false,
	enable = false,
	config = function()
		require("blame").setup({
			vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle virtual<CR>"),
		})
	end,
}
