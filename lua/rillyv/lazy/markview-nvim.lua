return {
	"OXY2DEV/markview.nvim",
	lazy = false,

	dependencies = { "saghen/blink.cmp" },

	config = function()
		require("markview").setup()

		vim.keymap.set("n", "<leader>mt", "<cmd>Markview toggle<CR>", { desc = "Toggle Markview" })
		vim.keymap.set("n", "<leader>ms", "<cmd>Markview splitToggle<CR>", { desc = "Split toggle Markview" })
		vim.keymap.set("n", "<leader>mh", "<cmd>Markview hybridToggle<CR>", { desc = "Hybrid toggle Markview" })
	end,
}
