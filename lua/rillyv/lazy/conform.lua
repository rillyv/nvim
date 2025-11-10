return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				php = { "php_cs_fixer" },
				lua = { "stylua" },
				go = { "gofmt" },
				sql = { "sql_formatter" },
				python = { "black", "isort" },
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
