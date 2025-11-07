return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt" },
				sql = { "sql_formatter" },
			},
			formatters = {
				sql_formatter = {
					command = "sql-formatter",
					args = {
						"-c",
						vim.fn.expand("~/.config/sql-formatter/config.json"),
					},
					stdin = true,
				},
			},
		})
	end,
}
