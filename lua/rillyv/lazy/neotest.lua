return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"olimorris/neotest-phpunit",
	},

	keys = {
		{
			"<leader>top",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Neotest output panel",
		},
		{
			"<leader>trn",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>ts",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop test",
		},
		{
			"<leader>tcf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run current file",
		},
		{
			"<leader>tra",
			function()
				require("neotest").run.run({ suite = true })
			end,
			desc = "Run all tests",
		},
		{
			"<leader>tdn",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Debug nearest test",
		},
		{
			"<leader>tan",
			function()
				require("neotest").run.attach()
			end,
			desc = "Attach to nearest test",
		},
		{
			"<leader>tso",
			function()
				require("neotest").output.open()
			end,
			desc = "Show test output",
		},
		{
			"<leader>tsu",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle summary",
		},
		{
			"<leader>tci",
			function()
				require("neotest").run.run({ suite = true, env = { CI = true } })
			end,
			desc = "Run all tests with CI=true",
		},
	},

	config = function()
		local neotest = require("neotest")

		neotest.setup({
			diagnostic = {
				enabled = false,
			},
			discovery = {
				enabled = false,
			},
			output_panel = {
				open = "botright vsplit | vertical resize 80",
			},
			adapters = {
				require("neotest-phpunit")({
					env = {
						XDEBUG_MODE = "debug",
						XDEBUG_TRIGGER = "1",
					},
				}),
			},
		})
	end,
}
