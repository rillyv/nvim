return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"L3MON4D3/LuaSnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		capabilities.general = capabilities.general or {}
		capabilities.general.positionEncodings = { "utf-16" }

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_installation = false,
			ensure_installed = {
				"ts_ls",
				"lua_ls",
				"pyright",
				"intelephense",
				"marksman",
				"jsonls",
				"html",
				"graphql",
				"dockerls",
				"terraformls",
				"ltex",
				"lemminx",
				"yamlls",
				"bashls",
				"gopls",
				"graphql",
				"sqls",
			},
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								telemetry = {
									enable = false,
								},
							},
						},
					})
				end,
				["ts_ls"] = function()
					require("lspconfig").ts_ls.setup({
						capabilities = capabilities,
						root_dir = require("lspconfig").util.root_pattern(
							"package.json",
							"tsconfig.json",
							"jsconfig.json",
							".git"
						),
						filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
						on_attach = function(client)
							client.server_capabilities.documentFormattingProvider = false
							client.server_capabilities.documentRangeFormattingProvider = false
						end,
					})
				end,
				["pyright"] = function()
					require("lspconfig").pyright.setup({
						capabilities = capabilities,
					})
				end,
				["intelephense"] = function()
					require("lspconfig").intelephense.setup({
						capabilities = capabilities,
						root_dir = require("lspconfig").util.root_pattern("composer.json", ".git"),
						settings = {
							intelephense = {
								diagnostics = {
									unusedSymbols = false,
								},
								files = {
									exclude = {
										"**/vendor/**",
										"**/var/**",
										"**/cache/**",
										"**/node_modules/**",
										"**/.git/**",
									},
								},
							},
						},
					})
				end,
				["marksman"] = function()
					require("lspconfig").marksman.setup({
						capabilities = capabilities,
					})
				end,
				["jsonls"] = function()
					require("lspconfig").jsonls.setup({
						capabilities = capabilities,
					})
				end,
				["html"] = function()
					require("lspconfig").html.setup({
						capabilities = capabilities,
					})
				end,
				["dockerls"] = function()
					require("lspconfig").dockerls.setup({
						capabilities = capabilities,
					})
				end,
				["terraformls"] = function()
					require("lspconfig").terraformls.setup({
						capabilities = capabilities,
					})
				end,
				["ltex"] = function()
					require("lspconfig").ltex.setup({
						capabilities = capabilities,
						filetypes = { "markdown", "text", "tex", "plaintex", "gitcommit" },
						settings = {
							ltex = {
								language = "en-US",
								additionalRules = {
									enablePickyRules = true,
									motherTongue = "en-US",
								},
								disabledRules = {},
								dictionary = {},
								checkFrequency = "save",
							},
						},
					})
				end,
				["lemminx"] = function()
					require("lspconfig").lemminx.setup({
						capabilities = capabilities,
					})
				end,
				["yamlls"] = function()
					require("lspconfig").yamlls.setup({
						capabilities = capabilities,
					})
				end,
				["bashls"] = function()
					require("lspconfig").bashls.setup({
						capabilities = capabilities,
					})
				end,
				["graphql"] = function()
					require("lspconfig").graphql.setup({
						capabilities = capabilities,
						cmd = { "graphql-lsp", "server", "-m", "stream" },
						filetypes = { "graphql", "gql", "graphqls" },
						root_dir = require("lspconfig").util.root_pattern(".graphqlrc*", "package.json", ".git"),
					})
				end,
				["sqls"] = function()
					require("lspconfig").sqls.setup({
						capabilities = capabilities,
						filetypes = { "sql", "mysql", "pgsql" },
						root_dir = require("lspconfig.util").root_pattern(".git"),
					})
				end,
			},
		})

		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		vim.lsp.inlay_hint.enable(true)
	end,
}
