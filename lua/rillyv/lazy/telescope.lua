return {
	"nvim-telescope/telescope.nvim",

	tag = "v0.1.9",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-dap.nvim",
	},

	config = function()
		require("telescope").setup({
			defaults = {
				path_display = { "full" },
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						width = 0.95,
						height = 0.95,
						preview_height = 0.6,
						preview_cutoff = 20,
						mirror = false,
					},
				},
			},

			pickers = {
				lsp_references = {
					show_line = false,
					fname_width = 120,
				},

				lsp_implementations = {
					path_display = { "none" },
					fname_width = 999,
					show_line = false,
				},

				lsp_definitions = {
					path_display = { "none" },
					fname_width = 999,
					show_line = false,
				},
			},
		})

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>pf", function()
			require("telescope.builtin").find_files({
				hidden = true,
				no_ignore = true,
			})
		end)
		vim.keymap.set("n", "<C-g>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			local cwd = vim.loop.cwd()

			require("telescope.builtin").live_grep({
				cwd = cwd,
				additional_args = function()
					return { "--hidden" }
				end,
			})
		end, { desc = "Live grep in project" })

		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
	end,
}
