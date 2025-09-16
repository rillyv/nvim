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
				typescript = { "eslint" },
				typescriptreact = { "eslint" },
				javascript = { "eslint" },
				javascriptreact = { "eslint" },
				twig = { "twig-cs-fixer" },
			},
			formatters = {
				php_cs_fixer = {
					command = "php",
					args = {
						"-d",
						"xdebug.mode=off",
						"vendor/bin/php-cs-fixer",
						"fix",
						"$FILENAME",
						"--quiet",
						"--using-cache=yes",
					},
					stdin = false,
				},
				sql_formatter = {
					command = "sql-formatter",
					args = {
						"-c",
						vim.fn.expand("~/.config/sql-formatter/config.json"),
					},
					stdin = true,
				},
				eslint = {
					command = "npx",
					args = {
						"eslint",
						"--fix",
						"--max-warnings=0",
						"--cache",
					},
					stdin = false,
					cwd = function(ctx)
						return ctx.root
					end,
				},
			},
		})
	end,
}
