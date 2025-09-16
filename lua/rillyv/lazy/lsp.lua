return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		require("conform").setup({
			formatters_by_ft = {
				python = { "black", "isort" },
				lua = { "stylua" },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.sql",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})

		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_installation = false,
			ensure_installed = {
				"ts_ls",
				"lua_ls",
				"eslint",
				"pyright",
				"intelephense",
				"phpactor",
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
					})
				end,
				["eslint"] = function()
					require("lspconfig").eslint.setup({
						capabilities = capabilities,
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
					})
				end,
				["phpactor"] = function()
					require("lspconfig").phpactor.setup({
						capabilities = capabilities,
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

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
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
	end,
}
